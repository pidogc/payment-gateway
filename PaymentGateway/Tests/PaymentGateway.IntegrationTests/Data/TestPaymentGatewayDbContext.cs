using System.Security.Authentication;
using Autofac;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.Extensions.Configuration;
using MySql.Data.MySqlClient;
using PaymentGateway.Domains;

namespace PaymentGateway.IntegrationTests.Data;

public interface IAppDbContext
{
}

public class TestPaymentGatewayDbContext(
    IdGenerator idGenerator,
    IConfiguration configuration) : DbContext, IAppDbContext
{
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(PaymentGatewayModule).Assembly);
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseMySql(
                configuration.GetValue<string>("ConnectionStrings:Mysql"),
                new MySqlServerVersion(new Version(5, 7, 33))
            )
            .EnableDetailedErrors()
            .EnableSensitiveDataLogging();
    }

    public override Task AddRangeAsync(IEnumerable<object> entities, CancellationToken cancellationToken = new())
    {
        var enumerable = entities as object[] ?? entities.ToArray();
        foreach (var entity in enumerable)
        {
            var idFieldInfo = entity.GetType().BaseType?.GetDeclaredProperty("Id");
            if (idFieldInfo != null && string.IsNullOrWhiteSpace((string)idFieldInfo.GetValue(entity)))
            {
                idFieldInfo.SetValue(entity, idGenerator.NewString());
            }
        }

        return base.AddRangeAsync(enumerable, cancellationToken);
    }

    public override ValueTask<EntityEntry<TEntity>> AddAsync<TEntity>(TEntity entity,
        CancellationToken cancellationToken = new())
    {
        var idFieldInfo = entity.GetType().BaseType?.GetDeclaredProperty("Id");
        if (idFieldInfo != null && string.IsNullOrWhiteSpace((string)idFieldInfo.GetValue(entity)))
        {
            idFieldInfo.SetValue(entity, idGenerator.NewString());
        }

        return base.AddAsync(entity, cancellationToken);
    }

    public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = new())
    {
        foreach (var entry in ChangeTracker.Entries<PaymentAuditedEntity>())
        {
            switch (entry.State)
            {
                case EntityState.Added:

                    if (string.IsNullOrWhiteSpace(entry.Entity.Id)) entry.Entity.Id = idGenerator.NewString();

                    if (entry.Entity.CreateAt.Equals(DateTimeOffset.MinValue))
                        entry.Entity.CreateAt = DateTimeOffset.UtcNow;

                    entry.Entity.UpdateAt = DateTimeOffset.UtcNow;
                    break;

                case EntityState.Modified:
                    entry.Entity.UpdateAt = DateTimeOffset.UtcNow;
                    break;
            }
        }

        var saved = false;
        while (!saved)
        {
            try
            {
                return await base.SaveChangesAsync(cancellationToken);
            }
            catch (DbUpdateConcurrencyException ex)
            {
                // await ex.Entries.First().ReloadAsync();
                saved = true;
                foreach (var entry in ex.Entries)
                {
                    var databaseValues = entry.GetDatabaseValues();
                    if (databaseValues != null)
                    {
                        // 将当前值重置为数据库中的值
                        entry.CurrentValues.SetValues(databaseValues);
                    }
                    else
                    {
                        entry.State = EntityState.Deleted;
                    }
                }
            }
            catch (DbUpdateException e)
            {
                saved = true;
                if (e.InnerException is AuthenticationException authenticationException)
                {
                    // 处理 SSL 认证错误的异常
                    return 0;
                }

                if (e.InnerException is MySqlException mysqlException)
                {
                    switch (mysqlException.Number)
                    {
                        case 1062:
                            // MySQL error code for duplicate entry
                            return 0;

                        case 1213:
                            // MySQL error code for deadlock
                            return 0;

                        default:
                            throw;
                    }
                }

                // Handle duplicate key exception
                RemoveRange(e.Entries);
                // Save changes to delete existing entities
                await base.SaveChangesAsync(cancellationToken);
                await AddRangeAsync(e.Entries, cancellationToken);
                // Retry SaveChangesAsync to insert new data
                return await base.SaveChangesAsync(cancellationToken);
            }
            catch (MySqlException ex)
            {
                saved = true;
                switch (ex.Number)
                {
                    case 1213: // 1213 是 MySQL 的死锁错误代码
                        return 0;

                    default:
                        if (ex.InnerException is AuthenticationException authenticationException)
                        {
                            // 处理 SSL 认证错误的异常
                            return 0;
                        }

                        // 处理其他类型的 MySqlException 异常
                        return 0;
                }
            }
        }

        return await Task.FromResult(0);
    }
}
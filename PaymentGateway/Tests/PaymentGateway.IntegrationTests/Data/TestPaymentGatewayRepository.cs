using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using PaymentGateway.Infrastructure;
using PaymentGateway.IntegrationTests.Data.Extensions;

namespace PaymentGateway.IntegrationTests.Data;

public class TestPaymentGatewayRepository(TestPaymentGatewayDbContext dbContext) : IPaymentRepository
{
    public async ValueTask<TEntity> GetByIdAsync<TEntity>(object id,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        return await dbContext.FindAsync<TEntity>(new object[] { id }, cancellationToken);
    }

    public async Task<List<TEntity>> GetAllAsync<TEntity>(CancellationToken cancellationToken = default)
        where TEntity : class
    {
        return await dbContext.Set<TEntity>().ToListAsync(cancellationToken);
    }

    public async Task<List<TEntity>> ToListAsync<TEntity>(Expression<Func<TEntity, bool>> predicate,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        return await dbContext.Set<TEntity>().Where(predicate).ToListAsync(cancellationToken);
    }

    public async Task InsertAsync<TEntity>(TEntity entity,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        await dbContext.AddAsync(entity, cancellationToken).ConfigureAwait(false);
        await dbContext.SaveChangesAsync(cancellationToken);
    }

    public async Task InsertAllAsync<TEntity>(IEnumerable<TEntity> entities,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        await dbContext.AddRangeAsync(entities, cancellationToken).ConfigureAwait(false);
        await dbContext.SaveChangesAsync(cancellationToken);
    }

    public async Task UpdateAsync<TEntity>(TEntity entity,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        dbContext.Update(entity);
        await dbContext.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
    }

    public async Task UpdateAllAsync<TEntity>(IEnumerable<TEntity> entities,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        dbContext.UpdateRange(entities);
        await dbContext.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
    }

    public async Task DeleteAsync<TEntity>(TEntity entity,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        var type = entity.GetType();
        if (typeof(ISoftDelete).IsAssignableFrom(type))
        {
            if (entity is ISoftDelete softDeleteEntity)
            {
                softDeleteEntity.IsDelete = true; // Set the IsDeleted property to true
                dbContext.Update(entity); // Mark the entity as modified
            }
        }
        else
        {
            dbContext.Entry(entity).State = EntityState.Deleted;
            dbContext.Remove(entity);
        }

        await dbContext.SaveChangesAsync(cancellationToken);
    }

    public async Task DeleteAsync<TEntity>(TEntity entity, bool isSoftDelete = true,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        var type = entity.GetType();
        if (typeof(ISoftDelete).IsAssignableFrom(type) && isSoftDelete)
        {
            if (entity is ISoftDelete softDeleteEntity)
            {
                softDeleteEntity.IsDelete = true; // Set the IsDeleted property to true
                dbContext.Update(entity); // Mark the entity as modified
            }
        }
        else
        {
            dbContext.Entry(entity).State = EntityState.Deleted;
            dbContext.Remove(entity);
        }

        await dbContext.SaveChangesAsync(cancellationToken);
    }

    public async Task DeleteAllAsync<TEntity>(IEnumerable<TEntity> entities,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        var enumerable = entities.ToList();
        if (enumerable.Count <= 0) return;

        if (typeof(ISoftDelete).IsAssignableFrom(enumerable.First().GetType()))
        {
            foreach (var entity in enumerable)
            {
                if (entity is not ISoftDelete softDeleteEntity) continue;
                softDeleteEntity.IsDelete = true; // Set the IsDeleted property to true
                dbContext.Update(entity); // Mark the entity as modified
            }
        }
        else
        {
            enumerable.ForEach(x => dbContext.Entry(x).State = EntityState.Deleted);
            dbContext.RemoveRange(enumerable);
        }

        await dbContext.SaveChangesAsync(cancellationToken);
    }

    public async Task DeleteAllAsync<TEntity>(IEnumerable<TEntity> entities, bool isSoftDelete = true,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        var enumerable = entities.ToList();
        if (enumerable.Count <= 0) return;

        if (typeof(ISoftDelete).IsAssignableFrom(enumerable.First().GetType()) && isSoftDelete)
        {
            foreach (var entity in enumerable)
            {
                if (entity is not ISoftDelete softDeleteEntity) continue;
                softDeleteEntity.IsDelete = true; // Set the IsDeleted property to true
                dbContext.Update(entity); // Mark the entity as modified
            }
        }
        else
        {
            enumerable.ForEach(x => dbContext.Entry(x).State = EntityState.Deleted);
            dbContext.RemoveRange(enumerable);
        }

        await dbContext.SaveChangesAsync(cancellationToken);
    }

    public Task<int> CountAsync<TEntity>(Expression<Func<TEntity, bool>> predicate,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        return dbContext.Set<TEntity>().CountAsync(predicate, cancellationToken);
    }

    public async Task<TEntity?> SingleOrDefaultAsync<TEntity>(Expression<Func<TEntity, bool>> predicate,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        return await dbContext.Set<TEntity>().SingleOrDefaultAsync(predicate, cancellationToken);
    }

    public async Task<TEntity?> FirstOrDefaultAsync<TEntity>(Expression<Func<TEntity, bool>> predicate,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        return await dbContext.Set<TEntity>().FirstOrDefaultAsync(predicate, cancellationToken);
    }

    public async Task<bool> AnyAsync<TEntity>(Expression<Func<TEntity, bool>> predicate,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        return await dbContext.Set<TEntity>().AnyAsync(predicate, cancellationToken);
    }

    public async Task<List<T>> SqlQueryAsync<T>(string sql, params object[] parameters) where T : class
    {
        return await dbContext.Set<T>().FromSqlRaw(sql, parameters).ToListAsync();
    }

    public IQueryable<TEntity> Query<TEntity>(Expression<Func<TEntity, bool>>? predicate = null)
        where TEntity : class
    {
        return predicate == null ? dbContext.Set<TEntity>() : dbContext.Set<TEntity>().Where(predicate);
    }

    public IQueryable<TEntity> QueryNoTracking<TEntity>(Expression<Func<TEntity, bool>>? predicate = null)
        where TEntity : class
    {
        return predicate == null
            ? dbContext.Set<TEntity>().AsNoTracking()
            : dbContext.Set<TEntity>().AsNoTracking().Where(predicate);
    }
}
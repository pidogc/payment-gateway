using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;

namespace PaymentGateway.IntegrationTests.Data.Extensions;

public static class SoftDeleteExtensions
{
    public static void SoftDeleteExtension<T>(this ModelBuilder modelBuilder)
    {
        foreach (var entityType in modelBuilder.Model.GetEntityTypes())
        {
            if (!typeof(T).IsAssignableFrom(entityType.ClrType)) continue;
            var isDeletedProperty = entityType.FindProperty("IsDelete");
            if (isDeletedProperty == null || isDeletedProperty.ClrType != typeof(bool)) continue;
            if (isDeletedProperty.PropertyInfo == null) continue;

            var parameter = Expression.Parameter(entityType.ClrType, "p");
            var filter = Expression.Lambda(
                Expression.Equal(
                    Expression.Property(parameter, isDeletedProperty.PropertyInfo),
                    Expression.Constant(false, typeof(bool))
                )
                , parameter);

            entityType.SetQueryFilter(filter);
        }
    }
}

public static class DetachAllExtension
{
    public static void DetachAll(this TestPaymentGatewayDbContext dbContext)
    {
        while (true)
        {
            //每次循环获取DbContext中一个被跟踪的实体
            var currentEntry = dbContext.ChangeTracker.Entries().FirstOrDefault();

            //currentEntry不为null，就将其State设置为EntityState.Detached，即取消跟踪该实体
            if (currentEntry != null)
            {
                //设置实体State为EntityState.Detached，取消跟踪该实体，之后dbContext.ChangeTracker.Entries().Count()的值会减1
                currentEntry.State = EntityState.Detached;
            }
            //currentEntry为null，表示DbContext中已经没有被跟踪的实体了，则跳出循环
            else
            {
                break;
            }
        }
    }
}
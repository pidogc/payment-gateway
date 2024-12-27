
using Microsoft.EntityFrameworkCore;

namespace PaymentGateway.Extensions;

public static class LinqExtension
{
    private static IQueryable<T> ApplyPaging<T>(this IQueryable<T> queryable, int pageIndex = 1, int pageSize = 15)
    {
        return queryable.Skip(pageSize * (pageIndex - 1)).Take(pageSize);
    }

    public static async Task<PagingResult<List<TEntity>>> PagingAsync<TEntity>(this IQueryable<TEntity> queryable,
        int page, int size,
        CancellationToken cancellationToken = default)
    {
        var totalElements = await queryable.CountAsync(cancellationToken);

        queryable = queryable.ApplyPaging(page, size);

        return new PagingResult<List<TEntity>>()
        {
            List = await queryable.ToListAsync(cancellationToken),
            TotalElements = totalElements
        };
    }
}

public class PagingResult<T>
{
    public T List { get; set; }
    public int TotalElements { get; set; }
}
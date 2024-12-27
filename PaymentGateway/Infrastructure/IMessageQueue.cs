namespace PaymentGateway.Infrastructure;

public interface IMessageQueue
{
    public Task SendAsync<T>(T t, CancellationToken cancellationToken);
    public Task<R> SendAsync<T, R>(T t, CancellationToken cancellationToken);
    public Task PublishAsync<T>(T t, CancellationToken cancellationToken);
}

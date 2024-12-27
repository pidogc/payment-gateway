using PaymentGateway.Domains;
using PaymentGateway.Strategy;

namespace PaymentGateway.Services;

public interface IPaymentSolutionStrategy : IPaymentGatewayService
{
    public ITransitionSolutionStrategy Strategy(PaymentConfig config);
    public Task<ITransitionSolutionStrategy> Strategy(string appId, string appSecret, CancellationToken cancellationToken  = default);
}
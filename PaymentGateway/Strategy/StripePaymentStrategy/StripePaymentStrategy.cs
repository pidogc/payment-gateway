using PaymentGateway.Domains;
using PaymentGateway.Infrastructure;

namespace PaymentGateway.Strategy.StripePaymentStrategy;

public class StripePaymentStrategy(IPaymentRepository repository, PaymentConfig config) : ITransitionSolutionStrategy
{
    public IPaymentConfigService Config { get; set; } = new StripeConfigService(repository, config);
    public IPaymentTransitionService Transition { get; set; } = new StripeTransitionService(config);
    public IPaymentTerminalService Terminal { get; set; } = new StripeTerminalService(config);
}
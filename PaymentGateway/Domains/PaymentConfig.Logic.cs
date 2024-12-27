using PaymentGateway.Infrastructure;
using PaymentGateway.Settings;
using PaymentGateway.Strategy;
using PaymentGateway.Strategy.RoosterPaymentStrategy;
using PaymentGateway.Strategy.StripePaymentStrategy;

namespace PaymentGateway.Domains;

public partial class PaymentConfig
{
    public ITransitionSolutionStrategy GetStrategy(IPaymentRepository repository, RoosterPaySetting roosterPaySetting)
    {
        return SolutionType switch
        {
            PaymentSolutionType.Stripe => new StripePaymentStrategy(repository, this),
            PaymentSolutionType.Rooster => new RoosterPaymentStrategy(repository, this, roosterPaySetting),
            _ => throw new Exception("Solution type not found")
        };
    }
}
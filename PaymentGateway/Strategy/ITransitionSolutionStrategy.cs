
namespace PaymentGateway.Strategy;

public interface ITransitionSolutionStrategy
{
    public IPaymentConfigService Config { get; set; }
    public IPaymentTransitionService Transition { get; set; }
    public IPaymentTerminalService Terminal { get; set; }
}

public enum PaymentSolutionType
{
    Cash = 0,
    Stripe = 1,
    Rooster = 2
}
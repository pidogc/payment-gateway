using PaymentGateway.Domains;
using PaymentGateway.Infrastructure;
using PaymentGateway.Settings;

namespace PaymentGateway.Strategy.RoosterPaymentStrategy;

public class RoosterPaymentStrategy(
    IPaymentRepository repository,
    PaymentConfig config,
    RoosterPaySetting roosterPaySetting
) : ITransitionSolutionStrategy
{
    public IPaymentConfigService Config { get; set; } = new RoosterConfigService(repository, config);
    public IPaymentTransitionService Transition { get; set; } = new RoosterTransitionService(config, roosterPaySetting);
    public IPaymentTerminalService Terminal { get; set; } = new RoosterTerminalService(config, roosterPaySetting);
}
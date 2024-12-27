using PaymentGateway.Messages;

namespace PaymentGateway.Strategy;

public interface IPaymentConfigService
{
    // 配置支付
    Task<PaymentConfigResponse> AddPaymentConfigAsync(PaymentAddress address,
        CancellationToken cancellationToken = default);

    Task<PaymentConfigResponse> UpdatePaymentConfigAsync(string config, CancellationToken cancellation = default);

    Task<bool> DeletePaymentConfigAsync(CancellationToken cancellation = default);
}
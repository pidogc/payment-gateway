using PaymentGateway.Messages;

namespace PaymentGateway.Strategy;

public interface IPaymentTransitionService
{
    // 支付
    public Task<PaymentRecord> CreatePaymentAsync(string payment, CancellationToken cancellation = default);

    public Task<PaymentRecord> CancelPaymentAsync(string paymentIntentId, CancellationToken cancellation = default);

    public Task<PaymentRecord> GetPaymentAsync(string payment, CancellationToken cancellation = default);

    public Task<PaymentRecord> IncrementAuthorizationPaymentAsync(string payment,
        CancellationToken cancellationToken = default);

    public Task<PaymentRecord> CapturePaymentAsync(string payment, CancellationToken cancellationToken = default);

    public Task<PaymentRecord> ReAuthorizePaymentAsync(string chargeId, decimal amount,
        CancellationToken cancellationToken = default);

    public Task<PaymentRecord> ConfirmAsync(string paymentIntentId, CancellationToken cancellationToken = default);

    // Capture 后退款
    public Task<PaymentRefundRecord> CreateRefundAsync(string payment, CancellationToken cancellationToken = default);

    public Task<PaymentRefundRecord> CancelRefundAsync(string refundId, CancellationToken cancellationToken = default);

    public Task<PaymentRefundRecord> GetRefundAsync(string refundId, CancellationToken cancellationToken = default);
}
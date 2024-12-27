using PaymentGateway.Messages;

namespace PaymentGateway.Strategy;

public interface IPaymentTerminalService
{
    // 刷卡机
    public Task<bool> ProcessTransitionAsync(
        string terminalId, string paymentIntentId, bool skipTipping = true, CancellationToken cancellation = default);

    public Task<ReaderMessage> AddAsync(string terminal, CancellationToken cancellation = default);

    public Task<ReaderMessage> UpdateAsync(string terminalId, string label, CancellationToken cancellation = default);

    public Task<ReaderMessage> GetAsync(string terminalId, CancellationToken cancellation = default);

    public Task<List<ReaderMessage>> AllAsync(CancellationToken cancellation = default);

    public Task<bool> DeleteAsync(string terminalId, CancellationToken cancellation = default);

    public Task<bool> CancelActionAsync(string terminalId, CancellationToken cancellation = default);

    public Task<bool> ConfigTipsAsync(bool tipsEnable, List<long?> tips, CancellationToken cancellation = default);

    public Task<ReaderMessage> PresentPaymentMethodAsync(string terminalId, CancellationToken cancellation = default);
}
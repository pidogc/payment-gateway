namespace PaymentGateway.Messages;

public class PaymentRefundRecord
{
    public string PaymentIntentId { get; set; }
    public string RefundId { get; set; }
    public decimal Amount { get; set; } = 0.00m;
    public Dictionary<string, string> Metadata { get; set; } = [];
    public string Reason { get; set; } = "";
    public PaymentStatus Status { get; set; }
}
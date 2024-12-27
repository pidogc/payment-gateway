namespace PaymentGateway.Dto;

public class CreatePaymentTransition
{
    public string TerminalId { get; set; } = "";
    public decimal PayAmount { get; set; } = 0.00m;
    public Dictionary<string, string> Metadata { get; set; } = [];
    public bool SkipTipping { get; set; } = true;
    public List<long> Tips { get; set; } = [];
}

public class IncrementPaymentTransition
{
    public string TerminalId { get; set; } = "";
    public string PaymentIntentId { get; set; } = "";
    public decimal IncrementAmount { get; set; } = 0.00m;
}

public class CapturePaymentTransition
{
    public string TerminalId { get; set; } = "";
    public string PaymentIntentId { get; set; } = "";
    public decimal CaptureAmount { get; set; } = 0.00m;
}

public class GetPaymentTransition
{
    public string PaymentIntentId { get; set; } = "";
    public DateTimeOffset StartTime { get; set; } = DateTimeOffset.Now;
    public DateTimeOffset EndTime { get; set; } = DateTimeOffset.Now;
}

public class CancelPaymentTransition
{
    public string TerminalId { get; set; } = "";
    public string PaymentIntentId { get; set; } = "";
    public decimal Amount { get; set; } = 0.00m;
    public string Type { get; set; } = "";
}

public class CreatePaymentRefundTransition
{
    public string TerminalId { get; set; } = "";
    public string PaymentIntentId { get; set; } = "";
    public decimal Amount { get; set; } = 0.00m;
    public string MerchantName { get; set; } = "";
    public string Type { get; set; } = "";
    public Dictionary<string, string> Metadata { get; set; } = [];
}

public class CancelPaymentRefundTransition
{
    public string TerminalId { get; set; } = "";
    public string PaymentIntentId { get; set; } = "";
}
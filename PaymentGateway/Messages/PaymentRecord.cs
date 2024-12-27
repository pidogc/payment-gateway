using System.ComponentModel;
using PaymentGateway.Extensions;
using Stripe;

namespace PaymentGateway.Messages;

public class PaymentRecord
{
    public string CustomerId { get; set; }
    public decimal PaidAmount { get; set; } = 0.00m;
    public decimal AmountRefunded { get; set; } = 0.00m;
    public PaymentStatus Status { get; set; }
    public string PaymentIntentId { get; set; }
    public string TerminalId { get; set; } = "";
    public string ChargeId { get; set; }
    public decimal RefundedAmount { get; set; }
    public decimal TipsAmount { get; set; } = 0.00m;

    public string Brand { get; set; } = "";
    public string Aid { get; set; } = "";
    public string AppLabel { get; set; } = "";
    public string Exp { get; set; } = "";
    public string ARQC { get; set; } = "";
    public string AuthCode { get; set; } = "";
    public string CustName { get; set; } = "";
    public string Last4 { get; set; }
    public string CardType { get; set; } = "";
    public StripeChargeStatus ChargeStatus { get; set; } = StripeChargeStatus.Pending;

    public Dictionary<string, string> Metadata { get; set; } = new();

    public bool HasCaptured { get; set; }
    public string Error { get; set; } = "";

    public PaymentRecord Setup(PaymentIntent paymentIntent)
    {
        CustomerId = paymentIntent.CustomerId;
        PaidAmount = paymentIntent.Amount / 100m;
        
        if (paymentIntent.Status == StripePaymentStatus.Canceled.ToDescription())
             Status = PaymentStatus.Canceled;
        
        if (paymentIntent.Status == StripePaymentStatus.RequiresPaymentMethod.ToDescription())
            Status = PaymentStatus.Unauthorized;
        
        if (paymentIntent.Status == StripePaymentStatus.Processing.ToDescription())
            Status = PaymentStatus.Authorized;

        if (paymentIntent.Status == StripePaymentStatus.RequiresCapture.ToDescription())
            Status = PaymentStatus.Authorized;
        
        if (paymentIntent.Status == StripePaymentStatus.Succeeded.ToDescription())
            Status = PaymentStatus.Captured;
        
        PaymentIntentId = paymentIntent.Id;
        HasCaptured = false;
        Error = paymentIntent.LastPaymentError?.Error ?? "";
        Metadata = paymentIntent.Metadata;
        TipsAmount = paymentIntent.AmountDetails.Tip.Amount  / 100m;
        return this;
    }
    
    public PaymentRecord Setup(Charge charge)
    {
        var details = charge.PaymentMethodDetails ?? null;
        if (details == null) return this;

        var month = details.CardPresent?.ExpMonth > 9
            ? $"{details.CardPresent?.ExpMonth}"
            : $"0{details.CardPresent?.ExpMonth ?? 0}";
        
        AmountRefunded = charge.AmountRefunded / 100m;
        AuthCode = charge.AuthorizationCode ?? "";
        Aid = details.CardPresent?.Receipt?.DedicatedFileName ?? "";
        AppLabel = $"{details.CardPresent?.Brand ?? ""} {details.CardPresent?.Funding ?? ""}".ToUpper();
        Exp = $"{month}{details.CardPresent?.ExpYear % 100}";
        ARQC = details.CardPresent?.Receipt?.ApplicationCryptogram ?? "";
        Brand = details.CardPresent?.Brand ?? "";
        ChargeId = charge.Id;
        Last4 = details.CardPresent?.Last4 ?? "";
        CustName = details.CardPresent?.CardholderName ?? "";
        ChargeStatus = charge.Status.ToEnum<StripeChargeStatus>();
        Error = charge?.FailureMessage?.SplitBy('.') ?? "";
        RefundedAmount = charge != null ? charge.AmountRefunded / 100m : 0.00m;
        return this;
    }
}

public enum PaymentStatus
{
    Unauthorized,
    Authorized,
    Captured,
    CaptureFailed,
    Canceled
}

public enum StripeChargeStatus
{
    [Description("pending")]
    Pending,
    [Description("failed")]
    Failed,
    [Description("succeeded")]
    Succeeded
}

public enum StripePaymentStatus
{
    [Description("processing")]
    Processing,
    [Description("canceled")]
    Canceled,
    [Description("succeeded")]
    Succeeded,
    [Description("requires_payment_method")]
    RequiresPaymentMethod,
    [Description("requires_capture")]
    RequiresCapture
} 
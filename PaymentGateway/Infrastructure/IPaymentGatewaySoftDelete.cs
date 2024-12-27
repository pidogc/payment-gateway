namespace PaymentGateway.Infrastructure;

public interface IPaymentGatewaySoftDelete
{
    public bool IsDelete { get; set; }
}
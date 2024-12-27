namespace PaymentGateway.Messages;

public class PaymentAddress
{
    public string City { get; set; }
    public string Country { get; set; }
    public string Line1 { get; set; }
    public string Line2 { get; set; }
    public string PostalCode { get; set; }
    public string State { get; set; }
}

public class PaymentConfigResponse
{
    public string AppId { get; set; }
    public string AppSecret { get; set; }
}
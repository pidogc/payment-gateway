namespace PaymentGateway.Dto;

public class RoosterPaymentConfig
{
    public const string BaseUrl = "https://triposcert.vantiv.com";
}

public class PaymentConfigDto
{
    public string SubjectName { get; set; }
    public string PaymentProviderKey { get; set; }
    public string PaymentProviderSecret { get; set; }
    public string LocationId { get; set; }
}
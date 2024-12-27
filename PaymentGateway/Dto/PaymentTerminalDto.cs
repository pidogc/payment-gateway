namespace PaymentGateway.Dto;

public class AddPaymentTerminalDto
{
    public string id { get; set; } = "";
    public string Code { get; set; }
    public string Label { get; set; }
}

public class UpdatePaymentTerminalDto
{
    public string TerminalId { get; set; }
    public string Code { get; set; }
}

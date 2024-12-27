using System.ComponentModel;

namespace PaymentGateway.Exceptions;

public class PaymentGatewayException(PaymentGatewayCode code, string message) : Exception
{
    public PaymentGatewayCode Code { get; } = code;
    public override string Message { get; } = message;
}

public class RoosterPayExceptionMessage
{
    public string ExceptionMessage { get; set; } = "";
}

public enum PaymentGatewayCode
{
    [Description("Internal error")] InternalError = 500,
    [Description("Parameter error")] ParameterError = 400,
    [Description("Not Found")] NotFoundError = 404,

    [Description("PaymentGatewayException: 1000, message: Terminal register code error")]
    TerminalRegisterCodeError = 1000
}
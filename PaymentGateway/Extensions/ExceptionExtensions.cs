using Newtonsoft.Json;
using PaymentGateway.Exceptions;
using Tripos.Exceptions;

namespace PaymentGateway.Extensions;

public static class ExceptionExtensions
{
    public static PaymentGatewayException RoosterPayException(Exception exception)
    {
        if (exception is not HttpClientException httpClientException)
            return new PaymentGatewayException(PaymentGatewayCode.InternalError, exception.Message);

        var errorResponse =
            JsonConvert.DeserializeObject<RoosterPayExceptionMessage>(httpClientException.ResponseBody);

        return errorResponse != null && !string.IsNullOrWhiteSpace(errorResponse.ExceptionMessage)
            ? new PaymentGatewayException(PaymentGatewayCode.InternalError, errorResponse.ExceptionMessage)
            : new PaymentGatewayException(PaymentGatewayCode.InternalError, httpClientException.Message);
    }
}

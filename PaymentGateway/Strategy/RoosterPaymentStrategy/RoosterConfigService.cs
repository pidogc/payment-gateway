using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Exceptions;
using PaymentGateway.Infrastructure;
using PaymentGateway.Messages;

namespace PaymentGateway.Strategy.RoosterPaymentStrategy;

public class RoosterConfigService(IPaymentRepository repository, PaymentConfig config) : IPaymentConfigService
{
    // Rooster config: key 对应AcceptorId, Secret对应Token, LocationId对应AccountId，配置文件配置的BaseUrl
    public async Task<PaymentConfigResponse> AddPaymentConfigAsync(PaymentAddress address,
        CancellationToken cancellationToken = default)
    {
        var paymentConfig = await new PaymentConfig()
        {
            AppId = Guid.NewGuid().ToString(),
            AppSecret = Guid.NewGuid().ToString(),
            SubjectId = config.SubjectId,
            SubjectName = config.SubjectName,
            PaymentProviderKey = config.PaymentProviderKey,
            PaymentProviderSecret = config.PaymentProviderSecret,
            SolutionType = config.SolutionType,
            LocationId = config.LocationId
        }.SaveAsync(repository, cancellationToken);

        return new()
        {
            AppId = paymentConfig.AppId,
            AppSecret = paymentConfig.AppSecret
        };
    }

    public async Task<PaymentConfigResponse> UpdatePaymentConfigAsync(string paymentConfig,
        CancellationToken cancellation = default)
    {
        var updatePaymentConfig = JsonConvert.DeserializeObject<PaymentConfigDto>(paymentConfig);
        if (updatePaymentConfig == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError, "Params format failed");

        config.PaymentProviderKey = updatePaymentConfig.PaymentProviderKey;
        config.PaymentProviderSecret = updatePaymentConfig.PaymentProviderSecret;
        config.LocationId = updatePaymentConfig.LocationId;
        config.SubjectName = updatePaymentConfig.SubjectName;

        await config.SaveAsync(repository, cancellation);

        return new()
        {
            AppId = config.AppId,
            AppSecret = config.AppSecret
        };
    }

    public async Task<bool> DeletePaymentConfigAsync(CancellationToken cancellation = default)
    {
        await config.DeleteAsync(repository, cancellation);
        return true;
    }
}
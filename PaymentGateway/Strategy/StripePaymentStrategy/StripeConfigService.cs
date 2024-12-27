using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Exceptions;
using PaymentGateway.Infrastructure;
using PaymentGateway.Messages;
using Stripe;
using Stripe.Terminal;

namespace PaymentGateway.Strategy.StripePaymentStrategy;

public class StripeConfigService(IPaymentRepository repository, PaymentConfig config) : IPaymentConfigService
{
    #region 配置支付

    public async Task<PaymentConfigResponse> AddPaymentConfigAsync(PaymentAddress address,
        CancellationToken cancellation = default)
    {
        var service = new LocationService(new StripeClient(apiKey: config.PaymentProviderKey));

        var location = await service.CreateAsync(new LocationCreateOptions()
        {
            DisplayName = config.SubjectName,
            Address = new()
            {
                Line1 = address.Line1,
                Line2 = address.Line2,
                City = address.City,
                State = address.State,
                Country = address.Country,
                PostalCode = address.PostalCode,
            }
        }, new() { ApiKey = config.PaymentProviderKey }, cancellation);

        var paymentConfig = await new PaymentConfig()
        {
            AppId = Guid.NewGuid().ToString(),
            AppSecret = Guid.NewGuid().ToString(),
            SubjectId = config.SubjectId,
            SubjectName = config.SubjectName,
            PaymentProviderKey = config.PaymentProviderKey,
            PaymentProviderSecret = config.PaymentProviderSecret,
            SolutionType = config.SolutionType,
            LocationId = location.Id
        }.SaveAsync(repository, cancellation);

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
        if (updatePaymentConfig == null) throw new Exception("Config format failed");

        config.PaymentProviderKey = updatePaymentConfig.PaymentProviderKey;
        config.PaymentProviderSecret = updatePaymentConfig.PaymentProviderSecret;
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
        try
        {
           await config.DeleteAsync(repository, cancellation);

            var service = new LocationService(new StripeClient(apiKey: config.PaymentProviderKey));
            await service.DeleteAsync(config.LocationId, null, null, cancellation);

            return true;
        }
        catch (Exception e)
        {
            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, e.Message);
        }
    }

    #endregion
}
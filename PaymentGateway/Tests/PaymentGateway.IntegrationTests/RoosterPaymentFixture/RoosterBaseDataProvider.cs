using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Infrastructure;
using PaymentGateway.IntegrationTests.Data;
using PaymentGateway.Messages;
using PaymentGateway.Settings;
using PaymentGateway.Strategy;
using PaymentGateway.Strategy.RoosterPaymentStrategy;
using PaymentGateway.Strategy.StripePaymentStrategy;

namespace PaymentGateway.IntegrationTests.RoosterPaymentFixture;

public class RoosterBaseDataProvider : BaseTest
{
    public const string LaneId = "666666";

    #region AddPaymentGatewayConfig

    public async Task<PaymentConfigResponse> AddStripePaymentGatewayConfig()
    {
        return await Run<IPaymentRepository, IdGenerator, RoosterPaySetting, Task<PaymentConfigResponse>>(
            async (repository, idGenerator, roosterPaySetting) =>
            {
                var subjectId = idGenerator.New().ToString();
                const string subjectName = "test store";
                const string locationId = "1091187";
                const string paymentProviderSecret =
                    "D59509CCCA5068F9B5D231EAC735B84348CDE8F861B8D5A8BF82B847749B0EB824175F01";
                const string paymentProviderKey = "874767787";

                var paymentStrategy = new RoosterPaymentStrategy(repository, new PaymentConfig()
                {
                    PaymentProviderKey = paymentProviderKey,
                    PaymentProviderSecret = paymentProviderSecret,
                    SubjectId = subjectId,
                    SubjectName = subjectName,
                    SolutionType = PaymentSolutionType.Rooster,
                    LocationId = locationId
                }, roosterPaySetting);

                return await paymentStrategy.Config.AddPaymentConfigAsync(null, CancellationToken.None)
                    .ConfigureAwait(false);
            });
    }

    #endregion

    #region AddTerminal

    public async Task<(PaymentConfigResponse, ReaderMessage)> AddStripeTerminal()
    {
        var paymentGatewayAppIdAndAppSecret = await AddStripePaymentGatewayConfig();
        return await Run<IPaymentRepository, RoosterPaySetting, Task<(PaymentConfigResponse, ReaderMessage)>>(
            async (repository, roosterPaySetting) =>
            {
                const string code = "simulated-wpe";
                var label = $"test-{new Random().Next(10, 100)}";

                var paymentConfig = await new PaymentConfig()
                {
                    AppId = paymentGatewayAppIdAndAppSecret.AppId,
                    AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
                }.LoadAsync(repository, default);

                var roosterPaymentStrategy = new RoosterPaymentStrategy(repository, paymentConfig, roosterPaySetting);

                var readerMessage = await roosterPaymentStrategy.Terminal.AddAsync(JsonConvert.SerializeObject(
                        new AddPaymentTerminalDto()
                        {
                            Code = code,
                            Label = label
                        }), new CancellationToken())
                    .ConfigureAwait(false);

                return (paymentGatewayAppIdAndAppSecret, readerMessage);
            });
    }

    #endregion
}
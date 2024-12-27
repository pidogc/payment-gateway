using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Infrastructure;
using PaymentGateway.IntegrationTests.Data;
using PaymentGateway.Messages;
using PaymentGateway.Strategy;
using PaymentGateway.Strategy.StripePaymentStrategy;

namespace PaymentGateway.IntegrationTests.StripePaymentServiceFixture;

public class StripeBaseDataProvider : BaseTest
{
    #region AddPaymentGatewayConfig

    public async Task<PaymentConfigResponse> AddStripePaymentGatewayConfig()
    {
        return await Run<IPaymentRepository, IdGenerator, Task<PaymentConfigResponse>>(
            async (repository, idGenerator) =>
            {
                var subjectId = idGenerator.New().ToString();
                const string subjectName = "test store";
                const string paymentProviderKey =
                    "rk_test_51EnLdRGUR6fOEWz7ZgDMC3ux5f44wgNkQxDqBWBIGhAQlpgDNTI05wmqfnYdVQ8k7koLywT13eIThFNHtFPnOETC00Za4RTZss";
                const string paymentProviderSecret = "";
                var address = new PaymentAddress()
                {
                    Country = "US",
                    City = "World Way",
                    State = "CA",
                    Line1 = "CA",
                    Line2 = "Los Angeles County",
                    PostalCode = "90045"
                };

                var stripePaymentService = new StripePaymentStrategy(repository, new PaymentConfig()
                {
                    PaymentProviderKey = paymentProviderKey,
                    PaymentProviderSecret = paymentProviderSecret,
                    SubjectId = subjectId,
                    SubjectName = subjectName,
                    SolutionType = PaymentSolutionType.Stripe
                });

                return await stripePaymentService.Config.AddPaymentConfigAsync(address, new CancellationToken())
                    .ConfigureAwait(false);
            });
    }

    #endregion

    #region AddTerminal

    public async Task<(PaymentConfigResponse, ReaderMessage)> AddStripeTerminal()
    {
        var paymentGatewayAppIdAndAppSecret = await AddStripePaymentGatewayConfig();
        return await Run<IPaymentRepository, Task<(PaymentConfigResponse, ReaderMessage)>>(
            async (repository) =>
            {
                const string code = "simulated-wpe";
                var label = $"test-{new Random().Next(10, 100)}";

                var paymentConfig = await new PaymentConfig()
                {
                    AppId = paymentGatewayAppIdAndAppSecret.AppId,
                    AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
                }.LoadAsync(repository, default);

                var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);

                var readerMessage = await stripePaymentService.Terminal.AddAsync(JsonConvert.SerializeObject(
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

    #region CreatePayment

    public async Task<(PaymentConfigResponse, ReaderMessage, PaymentRecord)> CreateStripePayment()
    {
        var (paymentGatewayAppIdAndAppSecret, readerMessage) = await AddStripeTerminal();
        return await Run<IPaymentRepository, IdGenerator,
            Task<(PaymentConfigResponse, ReaderMessage, PaymentRecord)>>(async (repository, idGenerator) =>
        {
            var payAmount = 10.00m;
            var companyId = idGenerator.New();
            var merchantId = idGenerator.New();
            var orderId = idGenerator.New();
            var paymentId = idGenerator.New();
            var staffId = idGenerator.New();
            var metadata = new Dictionary<string, string>()
            {
                {
                    "PaymentMetadata", JsonConvert.SerializeObject(new
                    {
                        Serial = idGenerator.New().ToString(),
                        From = "LEMON POS",
                        Mode = "ByOrder",
                        CompanyId = companyId,
                        MerchantId = merchantId,
                        OrderId = orderId,
                        PaymentId = paymentId,
                        TerminalId = readerMessage.TerminalId,
                        StaffId = staffId
                    })
                },
                {
                    "OrderId",
                    $"{orderId}"
                },
                {
                    "MerchantId",
                    $"{merchantId}"
                }
            };

            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, default);

            var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);

            var paymentRecord = await stripePaymentService.Transition.CreatePaymentAsync(JsonConvert.SerializeObject(
                new CreatePaymentTransition()
                {
                    PayAmount = payAmount,
                    Metadata = metadata,
                }), new CancellationToken()).ConfigureAwait(false);

            return (paymentGatewayAppIdAndAppSecret, readerMessage, paymentRecord);
        });
    }

    #endregion
}
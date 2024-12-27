using Microsoft.Extensions.Configuration;
using PaymentGateway.Domains;
using PaymentGateway.Infrastructure;
using PaymentGateway.IntegrationTests.Data;
using PaymentGateway.Settings;
using PaymentGateway.Strategy;
using PaymentGateway.Strategy.RoosterPaymentStrategy;
using PaymentGateway.Strategy.StripePaymentStrategy;
using Task = System.Threading.Tasks.Task;

namespace PaymentGateway.IntegrationTests.RoosterPaymentFixture;

public class RoosterPaymentConfigFixture : RoosterBaseDataProvider
{
    [Test]
    public async Task TestAddPaymentGatewayConfig()
    {
        await Run<IPaymentRepository, IdGenerator, IConfiguration, IPaymentRepository>(
            async (repository, idGenerator, configuration, paymentRepository) =>
            {
                var subjectId = idGenerator.New().ToString();
                const string subjectName = "test store";
                const string paymentProviderKey = "1091187";
                const string paymentProviderSecret =
                    "D59509CCCA5068F9B5D231EAC735B84348CDE8F861B8D5A8BF82B847749B0EB824175F01";
                const string locationId = "874767787";

                var roosterPaySetting = new RoosterPaySetting(configuration);
                var roosterPaymentStrategy = new RoosterPaymentStrategy(repository, new PaymentConfig()
                {
                    PaymentProviderKey = paymentProviderKey,
                    PaymentProviderSecret = paymentProviderSecret,
                    SubjectId = subjectId,
                    SubjectName = subjectName,
                    SolutionType = PaymentSolutionType.Rooster,
                    LocationId = locationId
                }, roosterPaySetting);

                var response = await roosterPaymentStrategy.Config.AddPaymentConfigAsync(null, CancellationToken.None)
                    .ConfigureAwait(false);

                Assert.That(response.AppId, Is.Not.Null);
                Assert.That(response.AppSecret, Is.Not.Null);

                var paymentConfig = await new PaymentConfig()
                {
                    AppId = response.AppId,
                    AppSecret = response.AppSecret,
                }.LoadAsync(paymentRepository, CancellationToken.None).ConfigureAwait(false);

                Assert.That(paymentConfig, Is.Not.Null);
                Assert.That(paymentConfig.SubjectId, Is.EqualTo(subjectId));
                Assert.That(paymentConfig.SubjectName, Is.EqualTo(subjectName));
                Assert.That(paymentConfig.PaymentProviderKey, Is.EqualTo(paymentProviderKey));
                Assert.That(paymentConfig.PaymentProviderSecret, Is.EqualTo(paymentProviderSecret));
            });
    }

    [Test]
    public async Task TestAddPaymentGatewayConfigByEncrypt()
    {
        await Run<IPaymentRepository, IdGenerator, IConfiguration, IPaymentRepository>(
            async (repository, idGenerator, configuration, paymentRepository) =>
            {
                var subjectId = idGenerator.New().ToString();
                const string subjectName = "test store";
                const string paymentProviderKey = "1091187";
                const string paymentProviderSecret =
                    "D59509CCCA5068F9B5D231EAC735B84348CDE8F861B8D5A8BF82B847749B0EB824175F01";
                const string locationId = "874767787";

                var roosterPaySetting = new RoosterPaySetting(configuration);
                var roosterPaymentStrategy = new RoosterPaymentStrategy(repository, new PaymentConfig()
                {
                    PaymentProviderKey = paymentProviderKey,
                    PaymentProviderSecret = paymentProviderSecret,
                    SubjectId = subjectId,
                    SubjectName = subjectName,
                    SolutionType = PaymentSolutionType.Rooster,
                    LocationId = locationId
                }, roosterPaySetting);

                var response = await roosterPaymentStrategy.Config.AddPaymentConfigAsync(null, CancellationToken.None)
                    .ConfigureAwait(false);

                Assert.That(response.AppId, Is.Not.Null);
                Assert.That(response.AppSecret, Is.Not.Null);

                var config = await new PaymentConfig()
                    {
                        AppId = response.AppId,
                        AppSecret = response.AppSecret,
                    }.SingOrDefaultAsync(paymentRepository, CancellationToken.None).ConfigureAwait(false);
                Assert.That(config!.PaymentProviderKey, Is.Not.EqualTo(paymentProviderKey));
                Assert.That(config.PaymentProviderSecret, Is.Not.EqualTo(paymentProviderSecret));
                Assert.That(config.LocationId, Is.EqualTo(locationId));
            });
    }
}
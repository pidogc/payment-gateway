using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Exceptions;
using PaymentGateway.Infrastructure;
using PaymentGateway.IntegrationTests.Data;
using PaymentGateway.Messages;
using PaymentGateway.Strategy;
using PaymentGateway.Strategy.StripePaymentStrategy;

namespace PaymentGateway.IntegrationTests.StripePaymentServiceFixture;

public class StripePaymentServiceFixtureConfigFixture : StripeBaseDataProvider
{
    [Test]
    public async Task TestAddPaymentGatewayConfig()
    {
        await Run<IPaymentRepository, IdGenerator, IPaymentRepository>(
            async (repository, idGenerator, paymentRepository) =>
            {
                var subjectId = idGenerator.New().ToString();
                var subjectName = "test store";
                var paymentProviderKey =
                    "rk_test_51EnLdRGUR6fOEWz7ZgDMC3ux5f44wgNkQxDqBWBIGhAQlpgDNTI05wmqfnYdVQ8k7koLywT13eIThFNHtFPnOETC00Za4RTZss";
                var paymentProviderSecret = "";
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

                var response = await stripePaymentService.Config.AddPaymentConfigAsync(address, CancellationToken.None)
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
        await Run<IPaymentRepository, IdGenerator, IPaymentRepository>(
            async (repository, idGenerator, paymentRepository) =>
            {
                var subjectId = idGenerator.New().ToString();
                var subjectName = "test store";
                var paymentProviderKey =
                    "rk_test_51EnLdRGUR6fOEWz7ZgDMC3ux5f44wgNkQxDqBWBIGhAQlpgDNTI05wmqfnYdVQ8k7koLywT13eIThFNHtFPnOETC00Za4RTZss";
                var paymentProviderSecret = "";
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

                var response = await stripePaymentService.Config.AddPaymentConfigAsync(address, CancellationToken.None)
                    .ConfigureAwait(false);

                Assert.That(response.AppId, Is.Not.Null);
                Assert.That(response.AppSecret, Is.Not.Null);

                var config = await new PaymentConfig()
                {
                    AppId = response.AppId,
                    AppSecret = response.AppSecret,
                }.SingOrDefaultAsync(paymentRepository, CancellationToken.None).ConfigureAwait(false);
                Assert.That(config!.PaymentProviderKey, Is.Not.EqualTo(paymentProviderKey));
                Assert.That(config.PaymentProviderSecret,
                    Is.EqualTo(""));
            });
    }

    [Test]
    public async Task TestUpdatePaymentGatewayConfig()
    {
        var paymentGatewayAppIdAndAppSecret = await AddStripePaymentGatewayConfig();
        await Run<IPaymentRepository, IdGenerator, IPaymentRepository>(
            async (repository, idGenerator, paymentRepository) =>
            {
                var updateSubjectName = "update store";
                var updatePaymentProviderKey = "123456";
                var updatePaymentProviderSecret = "123456";

                var paymentConfig = await new PaymentConfig()
                {
                    AppId = paymentGatewayAppIdAndAppSecret.AppId,
                    AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
                }.LoadAsync(repository, default);

                var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);

                var response = await stripePaymentService.Config.UpdatePaymentConfigAsync(JsonConvert.SerializeObject(
                        new PaymentConfigDto()
                        {
                            SubjectName = updateSubjectName,
                            PaymentProviderKey = updatePaymentProviderKey,
                            PaymentProviderSecret = updatePaymentProviderSecret
                        }), CancellationToken.None)
                    .ConfigureAwait(false);

                Assert.That(response.AppId, Is.EqualTo(paymentGatewayAppIdAndAppSecret.AppId));
                Assert.That(response.AppSecret, Is.EqualTo(paymentGatewayAppIdAndAppSecret.AppSecret));

                paymentConfig = await new PaymentConfig()
                {
                    AppId = paymentGatewayAppIdAndAppSecret.AppId,
                    AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret,
                }.LoadAsync(paymentRepository, CancellationToken.None).ConfigureAwait(false);

                Assert.That(paymentConfig, Is.Not.Null);
                Assert.That(paymentConfig.SubjectName, Is.EqualTo(updateSubjectName));
                Assert.That(paymentConfig.PaymentProviderKey, Is.EqualTo(updatePaymentProviderKey));
                Assert.That(paymentConfig.PaymentProviderSecret, Is.EqualTo(updatePaymentProviderSecret));
            });
    }

    [Test]
    public async Task TestDeletePaymentGatewayConfig()
    {
        var paymentGatewayAppIdAndAppSecret = await AddStripePaymentGatewayConfig();
        await Run<IPaymentRepository, IdGenerator, IPaymentRepository>(
            async (repository, idGenerator, paymentRepository) =>
            {
                try
                {
                    var paymentConfig = await new PaymentConfig()
                    {
                        AppId = paymentGatewayAppIdAndAppSecret.AppId,
                        AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
                    }.LoadAsync(repository, CancellationToken.None);

                    var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);

                    var response = await stripePaymentService.Config.DeletePaymentConfigAsync(CancellationToken.None)
                        .ConfigureAwait(false);

                    Assert.That(response, Is.True);

                    await new PaymentConfig()
                    {
                        AppId = paymentGatewayAppIdAndAppSecret.AppId,
                        AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret,
                    }.LoadAsync(paymentRepository, new CancellationToken()).ConfigureAwait(false);
                }
                catch (Exception e)
                {
                    Assert.That(e.Message, Is.EqualTo("PaymentConfig not found"));
                }
            });
    }

    [Test]
    public async Task TestDeletePaymentGatewayConfigThrow()
    {
        var paymentGatewayAppIdAndAppSecret = await AddStripePaymentGatewayConfig();
        await Run<IPaymentRepository>(
            async (repository) =>
            {
                var paymentConfig = await new PaymentConfig()
                {
                    AppId = paymentGatewayAppIdAndAppSecret.AppId,
                    AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
                }.LoadAsync(repository, CancellationToken.None);

                // 模拟一些错误
                paymentConfig.PaymentProviderKey = "12313";

                var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);

                Assert.ThrowsAsync<PaymentGatewayException>(async () =>
                {
                    await stripePaymentService.Config.DeletePaymentConfigAsync(CancellationToken.None)
                        .ConfigureAwait(false);
                });
            });
    }
}
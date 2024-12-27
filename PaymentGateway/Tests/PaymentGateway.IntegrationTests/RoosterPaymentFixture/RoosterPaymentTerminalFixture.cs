using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Exceptions;
using PaymentGateway.Infrastructure;
using PaymentGateway.Settings;
using PaymentGateway.Strategy.RoosterPaymentStrategy;

namespace PaymentGateway.IntegrationTests.RoosterPaymentFixture;

public class RoosterPaymentTerminalFixture : RoosterBaseDataProvider
{
    [Test]
    public async Task TestAddTerminal()
    {
        var paymentGatewayAppIdAndAppSecret = await AddStripePaymentGatewayConfig();
        await Run<IPaymentRepository, RoosterPaySetting>(async (repository, roosterPaySetting) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, default);

            var roosterPaymentStrategy = new RoosterPaymentStrategy(repository, paymentConfig, roosterPaySetting);

            const string code = "000000";
            var label = $"test-{new Random().Next(10, 100)}";
            try
            {
                await roosterPaymentStrategy.Terminal.AddAsync(JsonConvert.SerializeObject(
                    new AddPaymentTerminalDto()
                    {
                        id = LaneId,
                        Code = code,
                        Label = label
                    }), CancellationToken.None).ConfigureAwait(false);
                Assert.Fail();
            }
            catch (Exception e)
            {
                Assert.That(e, Is.InstanceOf<PaymentGatewayException>());
                Assert.That(e.Message, Is.EqualTo("Invalid activation code"));
            }
        });
    }

    [Test]
    public async Task TestDeleteTerminal()
    {
        var paymentGatewayAppIdAndAppSecret = await AddStripePaymentGatewayConfig();
        await Run<IPaymentRepository, RoosterPaySetting>(async (repository, roosterPaySetting) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, CancellationToken.None);

            var roosterPaymentStrategy = new RoosterPaymentStrategy(repository, paymentConfig, roosterPaySetting);

            var response = await roosterPaymentStrategy.Terminal.DeleteAsync(LaneId, CancellationToken.None)
                .ConfigureAwait(false);

            Assert.That(response, Is.True);

            // var readerMessage = await roosterPaymentStrategy.Terminal
            //     .GetAsync(response.TerminalId, new CancellationToken()).ConfigureAwait(false);
            //
            // Assert.That(readerMessage.TerminalId, Is.Not.Null);
            // Assert.That(readerMessage.Label, Is.EqualTo(label));
        });
    }

    [Test]
    public async Task TestGetTerminalNotFound()
    {
        var paymentGatewayAppIdAndAppSecret = await AddStripePaymentGatewayConfig();
        await Run<IPaymentRepository, RoosterPaySetting>(async (repository, roosterPaySetting) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, CancellationToken.None);

            var roosterPaymentStrategy = new RoosterPaymentStrategy(repository, paymentConfig, roosterPaySetting);

            try
            {
                await roosterPaymentStrategy.Terminal.GetAsync("0", CancellationToken.None)
                    .ConfigureAwait(false);
            }
            catch (Exception e)
            {
                Assert.That(e, Is.InstanceOf<PaymentGatewayException>());
                Assert.That(e.Message, Is.EqualTo("Invalid laneId"));
            }
        });
    }

    [Test]
    public async Task TestDeleteTerminalByNotFound()
    {
        var paymentGatewayAppIdAndAppSecret = await AddStripePaymentGatewayConfig();
        await Run<IPaymentRepository, RoosterPaySetting>(async (repository, roosterPaySetting) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, CancellationToken.None);

            var roosterPaymentStrategy = new RoosterPaymentStrategy(repository, paymentConfig, roosterPaySetting);

            var response = await roosterPaymentStrategy.Terminal
                .DeleteAsync((int.Parse(LaneId) + 1).ToString(), CancellationToken.None)
                .ConfigureAwait(false);

            Assert.That(response, Is.True);

            try
            {
                await roosterPaymentStrategy.Terminal.DeleteAsync("0", CancellationToken.None)
                    .ConfigureAwait(false);
            }
            catch (Exception e)
            {
                Assert.That(e, Is.InstanceOf<PaymentGatewayException>());
            }
        });
    }
}
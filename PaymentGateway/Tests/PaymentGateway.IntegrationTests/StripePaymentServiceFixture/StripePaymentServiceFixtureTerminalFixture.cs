using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Exceptions;
using PaymentGateway.Infrastructure;
using PaymentGateway.Messages;
using PaymentGateway.Strategy.StripePaymentStrategy;
using Random = System.Random;

namespace PaymentGateway.IntegrationTests.StripePaymentServiceFixture;

public class StripePaymentServiceFixtureTerminalFixture : StripeBaseDataProvider
{
    [Test]
    public async Task TestAddTerminal()
    {
        var paymentGatewayAppIdAndAppSecret = await AddStripePaymentGatewayConfig();
        await Run<IPaymentRepository>(async (repository) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, default);

            var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);

            const string code = "simulated-wpe";
            var label = $"test-{new Random().Next(10, 100)}";
            var response = await stripePaymentService.Terminal.AddAsync(JsonConvert.SerializeObject(
                new AddPaymentTerminalDto()
                {
                    Code = code,
                    Label = label
                }), new CancellationToken()).ConfigureAwait(false);

            Assert.That(response.TerminalId, Is.Not.Null);

            var readerMessage = await stripePaymentService.Terminal
                .GetAsync(response.TerminalId, new CancellationToken()).ConfigureAwait(false);

            Assert.That(readerMessage.TerminalId, Is.Not.Null);
            Assert.That(readerMessage.Label, Is.EqualTo(label));
        });
    }

    [Test]
    public async Task TestUpdateTerminal()
    {
        var (paymentGatewayAppIdAndAppSecret, readerMessage) = await AddStripeTerminal();
        await Run<IPaymentRepository>(async (repository) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, default);

            var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);

            var updateLabel = $"test--update-{new Random().Next(10, 100)}";
            var response = await stripePaymentService.Terminal
                .UpdateAsync(readerMessage.TerminalId, updateLabel, new CancellationToken()).ConfigureAwait(false);

            Assert.That(response.Label, Is.EqualTo(updateLabel));
        });
    }

    [Test]
    public async Task TestDeleteTerminal()
    {
        var (paymentGatewayAppIdAndAppSecret, readerMessage) = await AddStripeTerminal();
        await Run<IPaymentRepository>(async (repository) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, default);

            var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);

            var response = await stripePaymentService.Terminal.DeleteAsync(readerMessage.TerminalId,
                new CancellationToken()).ConfigureAwait(false);

            Assert.That(response, Is.True);

            try
            {
                await stripePaymentService.Terminal.GetAsync(readerMessage.TerminalId, new CancellationToken())
                    .ConfigureAwait(false);
            }
            catch (Exception e)
            {
                Assert.That(e, Is.InstanceOf<PaymentGatewayException>());
            }
        });
    }

    [Test]
    public async Task TestGetStatusOfflineWhenDeletedTerminal()
    {
        var (paymentGatewayAppIdAndAppSecret, readerMessage) = await AddStripeTerminal();
        await Run<IPaymentRepository>(async (repository) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, default);

            var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);
            var response = await stripePaymentService.Terminal.DeleteAsync(readerMessage.TerminalId,
                CancellationToken.None).ConfigureAwait(false);

            Assert.That(response, Is.True);

            var deletedReaderMessage = await stripePaymentService.Terminal
                .GetAsync(readerMessage.TerminalId, CancellationToken.None)
                .ConfigureAwait(false);

            Assert.Multiple(() =>
            {
                Assert.That(deletedReaderMessage.Deleted, Is.True);
                Assert.That(deletedReaderMessage.Status, Is.EqualTo(ReaderStatus.Offline));
            });
        });
    }
    
    [Test]
    public async Task TestUpdateTerminalStatusDeletedTerminal()
    {
        var (paymentGatewayAppIdAndAppSecret, readerMessage) = await AddStripeTerminal();
        await Run<IPaymentRepository>(async (repository) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, default);

            var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);
            var response = await stripePaymentService.Terminal.DeleteAsync(readerMessage.TerminalId,
                CancellationToken.None).ConfigureAwait(false);

            Assert.That(response, Is.True);

            var updateLabel = $"test--update-{new Random().Next(10, 100)}";
            var responseUpdated = await stripePaymentService.Terminal
                .UpdateAsync(readerMessage.TerminalId, updateLabel, CancellationToken.None).ConfigureAwait(false);
            
            Assert.Multiple(() =>
            {
                Assert.That(responseUpdated.Deleted, Is.True);
                Assert.That(responseUpdated.Status, Is.EqualTo(ReaderStatus.Offline));
            });
        });
    }
}
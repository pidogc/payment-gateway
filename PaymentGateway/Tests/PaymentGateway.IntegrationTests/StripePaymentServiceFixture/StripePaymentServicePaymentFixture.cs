using Core.Handlers.Command.PaymentGateway;
using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Infrastructure;
using PaymentGateway.IntegrationTests.Data;
using PaymentGateway.Messages;
using PaymentGateway.Strategy.StripePaymentStrategy;

namespace PaymentGateway.IntegrationTests.StripePaymentServiceFixture;

public class StripePaymentServicePaymentFixture : StripeBaseDataProvider
{
    [Test]
    public async Task TestCreatePayment()
    {
        var (paymentGatewayAppIdAndAppSecret, readerMessage) = await AddStripeTerminal();
        await Run<IPaymentRepository, IdGenerator>(async (repository, idGenerator) =>
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

            var createPaymentTransition = new CreatePaymentTransition()
            {
                PayAmount = payAmount,
                Metadata = metadata,
            };
            var responsePaymentRecord = await stripePaymentService.Transition
                .CreatePaymentAsync(JsonConvert.SerializeObject(createPaymentTransition), new CancellationToken())
                .ConfigureAwait(false);

            Assert.That(responsePaymentRecord.PaymentIntentId, Is.Not.Null);
            Assert.That(responsePaymentRecord.PaidAmount, Is.EqualTo(payAmount));
            Assert.That(responsePaymentRecord.Status, Is.EqualTo(PaymentStatus.Unauthorized));
            Assert.That(responsePaymentRecord.Metadata, Is.EqualTo(metadata));

            var record = await stripePaymentService.Transition
                .GetPaymentAsync(responsePaymentRecord.PaymentIntentId, new CancellationToken()).ConfigureAwait(false);
            Assert.That(record, Is.Not.Null);
        });
    }

    [Test]
    public async Task TestCancelPaymentAsync()
    {
        var (paymentGatewayAppIdAndAppSecret, readerMessage, paymentRecord) = await CreateStripePayment();
        await Run<IPaymentRepository, IdGenerator>(async (repository, idGenerator) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, default);

            var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);

            var responsePaymentRecord = await stripePaymentService.Transition
                .CancelPaymentAsync(paymentRecord.PaymentIntentId, new CancellationToken()).ConfigureAwait(false);

            Assert.That(responsePaymentRecord.Status, Is.EqualTo(PaymentStatus.Canceled));

            var record = await stripePaymentService.Transition
                .GetPaymentAsync(paymentRecord.PaymentIntentId, new CancellationToken()).ConfigureAwait(false);
            Assert.That(record, Is.Not.Null);
            Assert.That(record.Status, Is.EqualTo(PaymentStatus.Canceled));
        });
    }

    [Test]
    public async Task TestIncrementAuthorizationPaymentAsync()
    {
        var (paymentGatewayAppIdAndAppSecret, readerMessage, paymentRecord) = await CreateStripePayment();
        await Run<IPaymentRepository, IdGenerator>(async (repository, idGenerator) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, default);

            var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);

            var processPaymentAsync = await stripePaymentService.Terminal.ProcessTransitionAsync(
                readerMessage.TerminalId,
                paymentRecord.PaymentIntentId, true, new CancellationToken()).ConfigureAwait(false);
            Assert.That(processPaymentAsync, Is.True);

            var presentPaymentMethodAsync = await stripePaymentService.Terminal.PresentPaymentMethodAsync(
                readerMessage.TerminalId, new CancellationToken());
            Assert.That(presentPaymentMethodAsync.TransitionId, Is.EqualTo(paymentRecord.PaymentIntentId));


            var incrementAuthorizationAmount = paymentRecord.PaidAmount + 10.00m;
            var responsePaymentRecord = await stripePaymentService.Transition.IncrementAuthorizationPaymentAsync(
                    JsonConvert.SerializeObject(
                        new IncrementPaymentCommand()
                        {
                            PaymentIntentId = paymentRecord.PaymentIntentId,
                            IncrementAmount = paymentRecord.PaidAmount
                        }), new CancellationToken())
                .ConfigureAwait(false);

            Assert.That(responsePaymentRecord.PaidAmount, Is.EqualTo(incrementAuthorizationAmount));

            var record = await stripePaymentService.Transition
                .GetPaymentAsync(paymentRecord.PaymentIntentId, new CancellationToken()).ConfigureAwait(false);
            Assert.That(record, Is.Not.Null);
            Assert.That(record.PaidAmount, Is.EqualTo(incrementAuthorizationAmount));
        });
    }

    [Test]
    public async Task TestCapturePaymentAsync()
    {
        var (paymentGatewayAppIdAndAppSecret, readerMessage, paymentRecord) = await CreateStripePayment();
        await Run<IPaymentRepository, IdGenerator>(async (repository, idGenerator) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, default);

            var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);

            var processPaymentAsync = await stripePaymentService.Terminal.ProcessTransitionAsync(
                readerMessage.TerminalId,
                paymentRecord.PaymentIntentId, true,
                new CancellationToken()).ConfigureAwait(false);
            Assert.That(processPaymentAsync, Is.True);

            var presentPaymentMethodAsync = await stripePaymentService.Terminal.PresentPaymentMethodAsync(
                readerMessage.TerminalId, new CancellationToken());
            Assert.That(presentPaymentMethodAsync.TransitionId, Is.EqualTo(paymentRecord.PaymentIntentId));

            var capturePayment = await stripePaymentService.Transition.CapturePaymentAsync(JsonConvert.SerializeObject(
                new CapturePaymentCommand()
                {
                    PaymentIntentId = paymentRecord.PaymentIntentId,
                    CaptureAmount = paymentRecord.PaidAmount
                }), new CancellationToken()).ConfigureAwait(false);

            Assert.That(capturePayment.PaidAmount, Is.EqualTo(paymentRecord.PaidAmount));
            Assert.That(capturePayment.Status, Is.EqualTo(PaymentStatus.Captured));

            var record = await stripePaymentService.Transition.GetPaymentAsync(paymentRecord.PaymentIntentId,
                new CancellationToken()).ConfigureAwait(false);
            Assert.That(record, Is.Not.Null);
            Assert.That(record.Status, Is.EqualTo(PaymentStatus.Captured));
        });
    }

    [Test]
    public async Task TestReAuthorizePaymentAsync()
    {
        var (paymentGatewayAppIdAndAppSecret, readerMessage, paymentRecord) = await CreateStripePayment();
        await Run<IPaymentRepository, IdGenerator>(async (repository, idGenerator) =>
        {
            var paymentConfig = await new PaymentConfig()
            {
                AppId = paymentGatewayAppIdAndAppSecret.AppId,
                AppSecret = paymentGatewayAppIdAndAppSecret.AppSecret
            }.LoadAsync(repository, default);

            var stripePaymentService = new StripePaymentStrategy(repository, paymentConfig);

            var processPaymentAsync = await stripePaymentService.Terminal.ProcessTransitionAsync(
                readerMessage.TerminalId,
                paymentRecord.PaymentIntentId, true,
                new CancellationToken()).ConfigureAwait(false);
            Assert.That(processPaymentAsync, Is.True);

            var presentPaymentMethodAsync = await stripePaymentService.Terminal.PresentPaymentMethodAsync(
                readerMessage.TerminalId, new CancellationToken());
            Assert.That(presentPaymentMethodAsync.TransitionId, Is.EqualTo(paymentRecord.PaymentIntentId));

            var capturePayment = await stripePaymentService.Transition.CapturePaymentAsync(JsonConvert.SerializeObject(
                new CapturePaymentCommand()
                {
                    PaymentIntentId = paymentRecord.PaymentIntentId,
                    CaptureAmount = paymentRecord.PaidAmount
                }), new CancellationToken()).ConfigureAwait(false);

            Assert.That(capturePayment.Status, Is.EqualTo(PaymentStatus.Captured));
            Assert.That(capturePayment.PaidAmount, Is.EqualTo(paymentRecord.PaidAmount));

            const decimal reAmount = 200.00m;
            var reAuthorizePayment = await stripePaymentService.Transition.ReAuthorizePaymentAsync(
                capturePayment.ChargeId, reAmount, new CancellationToken());
            Assert.That(presentPaymentMethodAsync.TransitionId, Is.EqualTo(paymentRecord.PaymentIntentId));

            var record = await stripePaymentService.Transition.GetPaymentAsync(reAuthorizePayment.PaymentIntentId,
                new CancellationToken()).ConfigureAwait(false);
            Assert.That(record, Is.Not.Null);
            Assert.That(record.PaidAmount, Is.EqualTo(reAmount));
            Assert.That(record.Status, Is.EqualTo(PaymentStatus.Captured));
        });
    }
}
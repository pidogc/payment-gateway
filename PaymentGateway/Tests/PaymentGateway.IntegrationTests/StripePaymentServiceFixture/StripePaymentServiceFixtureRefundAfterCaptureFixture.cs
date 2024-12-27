using Core.Handlers.Command.PaymentGateway;
using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Infrastructure;
using PaymentGateway.IntegrationTests.Data;
using PaymentGateway.Messages;
using PaymentGateway.Strategy.StripePaymentStrategy;

namespace PaymentGateway.IntegrationTests.StripePaymentServiceFixture;

public class StripePaymentServiceFixtureRefundAfterCaptureFixture : StripeBaseDataProvider
{
    [Test]
    public async Task TestRefundAfterCapturePaymentAsync()
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

            var orderId = idGenerator.New();
            var merchantId = idGenerator.New();
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

            var paymentRefundTransition = new CreatePaymentRefundTransition()
            {
                PaymentIntentId = paymentRecord.PaymentIntentId,
                Amount = paymentRecord.PaidAmount,
                Metadata = new()
                {
                    {
                        "OrderId",
                        $"{orderId}"
                    },
                    {
                        "MerchantId",
                        $"{merchantId}"
                    }
                }
            };

            var paymentRefundRecordRes = await stripePaymentService.Transition.CreateRefundAsync(
                JsonConvert.SerializeObject(paymentRefundTransition), new CancellationToken());

            var paymentRefundRecord = await stripePaymentService.Transition.GetRefundAsync(
                paymentRefundRecordRes.RefundId,
                new CancellationToken());

            Assert.That(paymentRefundRecord.RefundId, Is.Not.Null);
            Assert.That(paymentRefundRecord.Amount, Is.EqualTo(paymentRecord.PaidAmount));
            Assert.That(paymentRefundRecord.Status, Is.EqualTo(PaymentStatus.Captured));

            var record = await stripePaymentService.Transition.GetPaymentAsync(paymentRecord.PaymentIntentId,
                new CancellationToken()).ConfigureAwait(false);
            Assert.That(record, Is.Not.Null);
            Assert.That(record.RefundedAmount, Is.EqualTo(paymentRecord.PaidAmount));
        });
    }
}
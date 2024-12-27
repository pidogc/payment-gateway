using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Exceptions;
using PaymentGateway.Extensions;
using PaymentGateway.Messages;
using Stripe;

namespace PaymentGateway.Strategy.StripePaymentStrategy;

public class StripeTransitionService(PaymentConfig config) : IPaymentTransitionService
{
    #region 创建支付

    public async Task<PaymentRecord> CreatePaymentAsync(string payment, CancellationToken cancellationToken = default)
    {
        var createPaymentTransition = JsonConvert.DeserializeObject<CreatePaymentTransition>(payment);
        if (createPaymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var paymentIntentService = new PaymentIntentService(stripeClient);
        var customerService = new CustomerService();
        var chargeService = new ChargeService(stripeClient);

        var customer = await customerService.CreateAsync(
            new() { },
            new()
            {
                ApiKey = config.PaymentProviderKey
            }, cancellationToken);

        var paymentIntent = await paymentIntentService.CreateAsync(new PaymentIntentCreateOptions()
        {
            Customer = customer.Id,
            SetupFutureUsage = "off_session",
            Amount = Convert.ToInt64(createPaymentTransition.PayAmount * 100),
            Currency = "usd",
            CaptureMethod = "manual",
            PaymentMethodTypes = new() { "card_present" },
            PaymentMethodOptions = new()
            {
                CardPresent = new()
                {
                    RequestIncrementalAuthorizationSupport = true,
                }
            },
            Metadata = createPaymentTransition.Metadata,
            StatementDescriptor = config.SubjectName,
            Description = config.SubjectName,
        }, new() { ApiKey = config.PaymentProviderKey }, cancellationToken);

        if (string.IsNullOrEmpty(paymentIntent.LatestChargeId)) return new PaymentRecord().Setup(paymentIntent);

        var charge = await chargeService.GetAsync(paymentIntent.LatestChargeId, null, null, cancellationToken);

        return new PaymentRecord().Setup(paymentIntent).Setup(charge);
    }

    #endregion

    #region 取消支付

    public async Task<PaymentRecord> CancelPaymentAsync(string payment,
        CancellationToken cancellation = default)
    {
        var paymentTransition = JsonConvert.DeserializeObject<CancelPaymentTransition>(payment);
        if (paymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var paymentIntentService = new PaymentIntentService(stripeClient);

        var paymentIntent = await paymentIntentService.CancelAsync(paymentTransition.PaymentIntentId, null,
            new() { ApiKey = config.PaymentProviderKey }, cancellation);

        return new PaymentRecord().Setup(paymentIntent);
    }

    #endregion

    #region 根据paymentIntentId、incrementAuthorization获取支付

    public async Task<PaymentRecord> GetPaymentAsync(string payment, CancellationToken cancellation = default)
    {
        var getPaymentTransition = JsonConvert.DeserializeObject<GetPaymentTransition>(payment);
        if (getPaymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var chargeService = new ChargeService(stripeClient);
        var paymentIntentService = new PaymentIntentService(stripeClient);
        var paymentIntent = await paymentIntentService.GetAsync(getPaymentTransition.PaymentIntentId, null,
            new() { ApiKey = config.PaymentProviderKey }, cancellation);

        if (string.IsNullOrEmpty(paymentIntent.LatestChargeId)) return new PaymentRecord().Setup(paymentIntent);

        var charge = await chargeService.GetAsync(paymentIntent.LatestChargeId, null, null, cancellation);

        return new PaymentRecord().Setup(paymentIntent).Setup(charge);
    }

    #endregion

    #region 增量授權

    public async Task<PaymentRecord> IncrementAuthorizationPaymentAsync(string payment,
        CancellationToken cancellationToken = default)
    {
        var incrementPaymentTransition = JsonConvert.DeserializeObject<IncrementPaymentTransition>(payment);
        if (incrementPaymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var paymentIntentService = new PaymentIntentService(stripeClient);
        var chargeService = new ChargeService(stripeClient);

        var paymentIntent = await paymentIntentService.IncrementAuthorizationAsync(
            incrementPaymentTransition.PaymentIntentId,
            new()
            {
                Amount = Convert.ToInt64(incrementPaymentTransition.IncrementAmount * 100),
            }, new() { ApiKey = config.PaymentProviderKey }, cancellationToken);
        var charge = await chargeService.GetAsync(paymentIntent.LatestChargeId, null, null, cancellationToken);

        return new PaymentRecord().Setup(paymentIntent).Setup(charge);
    }

    #endregion

    #region 捕獲支付

    public async Task<PaymentRecord> CapturePaymentAsync(string payment, CancellationToken cancellationToken = default)
    {
        var capturePaymentTransition = JsonConvert.DeserializeObject<CapturePaymentTransition>(payment);
        if (capturePaymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var paymentIntentService = new PaymentIntentService(stripeClient);
        var chargeService = new ChargeService(stripeClient);

        var paymentIntent = await paymentIntentService.CaptureAsync(capturePaymentTransition.PaymentIntentId,
            new PaymentIntentCaptureOptions()
            {
                AmountToCapture = Convert.ToInt64(capturePaymentTransition.CaptureAmount * 100),
            }, new() { ApiKey = config.PaymentProviderKey }, cancellationToken);

        var charge = await chargeService.GetAsync(paymentIntent.LatestChargeId, null, null, cancellationToken);

        return new PaymentRecord()
            .Setup(paymentIntent)
            .Setup(charge);
    }

    #endregion

    #region 重新授权

    public async Task<PaymentRecord> ReAuthorizePaymentAsync(string chargeId, decimal amount,
        CancellationToken cancellationToken = default)
    {
        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var paymentIntentService = new PaymentIntentService(stripeClient);
        var chargeService = new ChargeService(stripeClient);
        var charge = await chargeService.GetAsync(chargeId, null, null, cancellationToken);

        var paymentIntent = await paymentIntentService.CreateAsync(new PaymentIntentCreateOptions()
        {
            CaptureMethod = "manual",
            Confirm = true,
            Amount = Convert.ToInt64(amount * 100),
            Currency = "usd",
            PaymentMethod = charge.PaymentMethodDetails.CardPresent.GeneratedCard,
            Customer = charge.CustomerId,
            Metadata = charge.Metadata,
            AutomaticPaymentMethods = new()
            {
                Enabled = true,
                AllowRedirects = "never"
            },
            StatementDescriptorSuffix = charge.StatementDescriptor,
            Description = charge.Description
        }, new() { ApiKey = config.PaymentProviderKey }, cancellationToken);

        var capturePaymentIntent = await paymentIntentService.CaptureAsync(paymentIntent.Id,
            new()
            {
                AmountToCapture = paymentIntent.Amount
            }, new() { ApiKey = config.PaymentProviderKey }, cancellationToken);

        charge = await chargeService.GetAsync(capturePaymentIntent.LatestChargeId, null, null, cancellationToken);

        return new PaymentRecord().Setup(capturePaymentIntent).Setup(charge);
    }

    public async Task<PaymentRecord> ConfirmAsync(string paymentIntentId,
        CancellationToken cancellationToken = default)
    {
        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var paymentIntentService = new PaymentIntentService(stripeClient);
        var chargeService = new ChargeService(stripeClient);

        var paymentIntent = await paymentIntentService.ConfirmAsync(paymentIntentId, new(),
            new() { ApiKey = config.PaymentProviderKey }, cancellationToken);

        if (string.IsNullOrEmpty(paymentIntent.LatestChargeId)) return new PaymentRecord().Setup(paymentIntent);

        var charge = await chargeService.GetAsync(paymentIntent.LatestChargeId, null, null, cancellationToken);

        return new PaymentRecord().Setup(paymentIntent).Setup(charge);
    }

    #endregion


    public async Task<PaymentRefundRecord> CreateRefundAsync(string payment,
        CancellationToken cancellationToken = default)
    {
        var paymentRefundTransition = JsonConvert.DeserializeObject<CreatePaymentRefundTransition>(payment);
        if (paymentRefundTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var refundService = new RefundService(stripeClient);

        var refund = await refundService.CreateAsync(new()
        {
            PaymentIntent = paymentRefundTransition.PaymentIntentId,
            Amount = Convert.ToInt64(paymentRefundTransition.Amount * 100),
            Metadata = paymentRefundTransition.Metadata
        }, new()
        {
            ApiKey = config.PaymentProviderKey
        }, cancellationToken).ConfigureAwait(false);

        return new()
        {
            PaymentIntentId = refund.PaymentIntentId,
            RefundId = refund.Id,
            Amount = refund.Amount / 100m,
            Metadata = refund.Metadata,
            Reason = refund.Reason,
            Status = refund.Status switch
            {
                "succeeded" => PaymentStatus.Captured,
                "failed" => PaymentStatus.CaptureFailed,
                "canceled" => PaymentStatus.Canceled,
                _ => PaymentStatus.Authorized
            }
        };
    }

    public async Task<PaymentRefundRecord> CancelRefundAsync(string payment, CancellationToken cancellationToken = default)
    {
        var paymentTransition = JsonConvert.DeserializeObject<CancelPaymentRefundTransition>(payment);
        if (paymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());
        
        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var refundService = new RefundService(stripeClient);

        var refund = await refundService.CancelAsync(paymentTransition.PaymentIntentId, null, new()
        {
            ApiKey = config.PaymentProviderKey
        }, cancellationToken).ConfigureAwait(false);

        return new()
        {
            PaymentIntentId = refund.PaymentIntentId,
            RefundId = refund.Id,
            Amount = refund.Amount / 100m,
            Metadata = refund.Metadata,
            Reason = refund.Reason,
            Status = refund.Status switch
            {
                "succeeded" => PaymentStatus.Captured,
                "failed" => PaymentStatus.CaptureFailed,
                "canceled" => PaymentStatus.Canceled,
                _ => PaymentStatus.Authorized
            }
        };
    }

    public async Task<PaymentRefundRecord> GetRefundAsync(string payment,
        CancellationToken cancellationToken = default)
    {
        var paymentTransition = JsonConvert.DeserializeObject<GetPaymentTransition>(payment);
        if (paymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());
        
        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var refundService = new RefundService(stripeClient);

        var refund = await refundService.GetAsync(paymentTransition.PaymentIntentId, null, new()
        {
            ApiKey = config.PaymentProviderKey
        }, cancellationToken).ConfigureAwait(false);

        return new()
        {
            PaymentIntentId = refund.PaymentIntentId,
            RefundId = refund.Id,
            Amount = refund.Amount / 100m,
            Metadata = refund.Metadata,
            Reason = refund.Reason,
            Status = refund.Status switch
            {
                "succeeded" => PaymentStatus.Captured,
                "failed" => PaymentStatus.CaptureFailed,
                "canceled" => PaymentStatus.Canceled,
                _ => PaymentStatus.Authorized
            }
        };
    }
}
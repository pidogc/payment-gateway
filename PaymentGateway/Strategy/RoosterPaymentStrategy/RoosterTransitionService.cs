using System.Text.RegularExpressions;
using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Exceptions;
using PaymentGateway.Extensions;
using PaymentGateway.Messages;
using PaymentGateway.Settings;
using Serilog;
using Tripos;
using Tripos.Exceptions;
using Tripos.Service.Authorization;
using Tripos.Service.Input;
using Tripos.Service.Return;
using Tripos.Service.Reversal;
using Tripos.Service.Selection;
using Tripos.Service.TransactionQuery;
using Tripos.Service.Void;

namespace PaymentGateway.Strategy.RoosterPaymentStrategy;

/**
 * Complete 相当于 Stripe Capture
 * Transaction Query:
 *      Status: [授权]Authorization -> Authorized Type: CreditCardAuthorization
 *      Status: Incremental -> Authorized Type: CreditCardAuthorization
 *      Status: Complete -> AuthCompleted Type: CreditCardAuthorization
 *      Status: [订单Complete之前退款]Reversal -> Reversed Type: CreditCardReversal
 *      Status: [订单Complete之后退款]Return -> Approved Type: CreditCardReturn
 *      Status: [订单Complete之后退款]Void -> Success Type: CreditCardVoid
 *
 * InputService(https://triposcert.vantiv.com/api/help/kb/input.html)
 * InputService PromptType: tip、cashback、amount、zip、phone、easyPayCode、data、serverId、checkNumber、tableNumber
 * InputService FormatType：none、amountWithComma、amountWithDollarComma、amountWithDollarCommaDecimal、phoneWithAreaCodeSeparatorAndDashes、allowLeadingZero
 *
 *
 */
public partial class RoosterTransitionService(
    PaymentConfig config,
    RoosterPaySetting roosterPaySetting
) : IPaymentTransitionService
{
    public TriposClient GetTriposClient(string acceptorId, string accountId, string token)
    {
        var triposConfig = new TriposConfig(roosterPaySetting.Url, acceptorId, accountId, token)
        {
            ApplicationId = roosterPaySetting.ApplicationId,
            ApplicationName = roosterPaySetting.ApplicationName,
            ApplicationVersion = roosterPaySetting.ApplicationVersion
        };
        return new TriposClient(triposConfig);
    }

    public async Task<PaymentRecord> CreatePaymentAsync(string payment, CancellationToken cancellation = default)
    {
        var createPaymentTransition = JsonConvert.DeserializeObject<CreatePaymentTransition>(payment);
        if (createPaymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var authorizationService = new AuthorizationService(triposClient);

        try
        {
            var tipsAmount = 0.00m;

            if (createPaymentTransition is { SkipTipping: false, Tips.Count: > 0 })
            {
                var join = string.Join("|",
                               createPaymentTransition.Tips.Select(x =>
                                   $"{x}% ${decimal.Round(x * createPaymentTransition.PayAmount / 100, 2)}")) +
                           "|other ";
                var selectionService = new SelectionService(triposClient);
                try
                {
                    var selectionResponse = await selectionService.GetAsync(
                            int.Parse(createPaymentTransition.TerminalId),
                            RoosterSelectionFormType.MultiOption,
                            options: join,
                            text: "Choose Tips",
                            multiLineText: "line1|line2|line3|line4",
                            cancellationToken: cancellation)
                        .ConfigureAwait(false);
                    if (!selectionResponse.HasErrors)
                    {
                        if (selectionResponse.SelectionIndex == 3)
                        {
                            var inputService = new InputService(triposClient);
                            var inputResponse = await inputService.GetAsync(
                                int.Parse(createPaymentTransition.TerminalId),
                                RoosterInputPromptType.Tip,
                                RoosterInputFormatType.AmountWithDollarCommaDecimal,
                                cancellation).ConfigureAwait(false);
                            if (!inputResponse.HasErrors)
                            {
                                tipsAmount = decimal.Round(decimal.Parse(inputResponse.InputText) / 100, 2);
                            }
                        }
                        else
                        {
                            tipsAmount =
                                decimal.Round(
                                    createPaymentTransition.PayAmount *
                                    createPaymentTransition.Tips[selectionResponse.SelectionIndex] / 100,
                                    2);
                        }
                    }
                }
                catch (Exception exception)
                {
                    Log.Error("Select Tips Rooster Pay Transaction error:{@exception}", exception);
                    tipsAmount = 0.00m;
                }
            }

            var response = await authorizationService.CreateCardAuthorizationAsync(new(
                int.Parse(createPaymentTransition.TerminalId),
                (double)createPaymentTransition.PayAmount)
            {
                TipAmount = (double)tipsAmount
            }, cancellationToken: cancellation);

            Log.Error("Create Authorization Rooster Pay Transaction error:{@response}", response);

            if (response is { IsApproved: true })
            {
                return new PaymentRecord()
                {
                    PaymentIntentId = response.TransactionId,
                    TerminalId = response.TerminalId,
                    ChargeId = response.ApprovalNumber,
                    HasCaptured = false,
                    Exp = $"{response.ExpirationMonth}{response.ExpirationYear}",
                    RefundedAmount = 0.00m,
                    AmountRefunded = 0.00m,
                    Aid = response?.Emv?.ApplicationIdentifier ?? "",
                    AppLabel = response?.Emv?.ApplicationLabel ?? "",
                    ARQC = response?.Emv?.Cryptogram ?? "",
                    Last4 = response?.AccountNumber[^4..] ?? "",
                    CustName = response?.CardHolderName ?? "",
                    Brand = response?.CardLogo ?? "",
                    AuthCode = response?.ApprovalNumber ?? "",
                    PaidAmount = (decimal)response!.TotalAmount,
                    ChargeStatus = StripeChargeStatus.Succeeded,
                    Status = response.IsApproved ? PaymentStatus.Authorized : PaymentStatus.Canceled,
                    TipsAmount = (decimal)response.TipAmount
                };
            }

            var message = string.IsNullOrWhiteSpace(response?.QuickChipMessage)
                ? response?.Processor?.ExpressResponseMessage
                : response?.QuickChipMessage;

            if (response?.Errors?.Count > 0)
            {
                message = response.Errors.First().ExceptionMessage;
            }

            message = string.IsNullOrWhiteSpace(message)
                ? !string.IsNullOrWhiteSpace(response?.StatusCode)
                    ? SpacesToPascalCase(response.StatusCode)
                    : "Payment Cancelled"
                : message;
            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, message);
        }
        catch (Exception e)
        {
            Log.Error("Create Authorization Rooster Pay Transaction error:{@e}", e);
            throw ExceptionExtensions.RoosterPayException(e);
        }
    }

    public async Task<PaymentRecord> CancelPaymentAsync(string payment, CancellationToken cancellation = default)
    {
        var paymentTransition = JsonConvert.DeserializeObject<CancelPaymentTransition>(payment);
        if (paymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var reversalService = new ReversalService(triposClient);

        try
        {
            var response = await reversalService.CreateFullReversalAsync(new(
                int.Parse(paymentTransition.TerminalId),
                (double)paymentTransition.Amount
            ), paymentTransition.Type, paymentTransition.PaymentIntentId, cancellationToken: cancellation);

            if (response is { IsApproved: true })
            {
                return new PaymentRecord()
                {
                    PaymentIntentId = response.TransactionId,
                    ChargeId = response.ApprovalNumber,
                    TerminalId = response.TerminalId,
                    HasCaptured = false,
                    RefundedAmount = (decimal)response.TotalAmount,
                    AmountRefunded = (decimal)response.TotalAmount,
                    Last4 = response.AccountNumber[^4..],
                    Brand = response.CardLogo,
                    AuthCode = response.ApprovalNumber,
                    PaidAmount = (decimal)response.TotalAmount,
                    Status = response.IsApproved ? PaymentStatus.Canceled : PaymentStatus.Authorized
                };
            }

            var message = response?.Processor?.ExpressResponseMessage;

            message = string.IsNullOrWhiteSpace(message)
                ? response?.StatusCode ?? "Payment Cancelled Failed"
                : message;
            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, message);
        }
        catch (Exception e)
        {
            Log.Error("Cancel Rooster Pay Transaction error:{@e}", e);
            throw ExceptionExtensions.RoosterPayException(e);
        }
    }

    public async Task<PaymentRecord> GetPaymentAsync(string payment, CancellationToken cancellation = default)
    {
        var paymentTransition = JsonConvert.DeserializeObject<GetPaymentTransition>(payment);
        if (paymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var authorizationService = new TransactionQueryService(triposClient);

        try
        {
            var response = await authorizationService.TransactionQueryAsync(new("", "", "",
                    paymentTransition.StartTime.ToString("yyyy-MM-dd HH:mm:ss"),
                    paymentTransition.EndTime.ToString("yyyy-MM-dd HH:mm:ss"), paymentTransition.PaymentIntentId),
                cancellation);

            var transactionList = response.ReportingData;
            if (transactionList.Count == 0)
            {
                throw new PaymentGatewayException(PaymentGatewayCode.NotFoundError, "Transaction not found");
            }

            var transaction = transactionList
                .Where(x => CheckTransactionStatusSuccess(x.ExpressResponseCode))
                .OrderByDescending(x => $"{x.ExpressTransactionDate}${x.ExpressTransactionTime}").FirstOrDefault();
            if (transaction == null)
            {
                throw new PaymentGatewayException(PaymentGatewayCode.NotFoundError,
                    "Transaction status does not matched");
            }

            return new PaymentRecord()
            {
                PaymentIntentId = transaction.TransactionId,
                TerminalId = transaction.TerminalId,
                ChargeId = transaction.ApprovalNumber,
                HasCaptured = false,
                Exp = $"{transaction.ExpirationMonth}{transaction.ExpirationYear}",
                RefundedAmount = 0.00m,
                AmountRefunded = 0.00m,
                Last4 = transaction.CardNumberMasked[^4..],
                Brand = transaction.CardLogo,
                AuthCode = transaction.ApprovalNumber,
                CardType = transaction.CardType,
                PaidAmount = (decimal)transaction.ApprovedAmount,
                ChargeStatus = StripeChargeStatus.Succeeded,
            };
        }
        catch (Exception e)
        {
            Log.Error("Get Rooster Pay Transaction error:{@e}", e);
            throw ExceptionExtensions.RoosterPayException(e);
        }
    }

    public async Task<PaymentRecord> IncrementAuthorizationPaymentAsync(string payment,
        CancellationToken cancellationToken = default)
    {
        var incrementPaymentTransition = JsonConvert.DeserializeObject<IncrementPaymentTransition>(payment);
        if (incrementPaymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var authorizationService = new AuthorizationService(triposClient);

        try
        {
            var response = await authorizationService.IncreasePreviousCardAuthorizationAsync(
                incrementPaymentTransition.PaymentIntentId,
                new(int.Parse(incrementPaymentTransition.TerminalId),
                    (double)incrementPaymentTransition.IncrementAmount), cancellationToken);

            if (response is not { IsApproved: true })
            {
                var errorMessage = response?.Processor?.ExpressResponseMessage;
                if (response?.Errors?.Count > 0)
                {
                    errorMessage = response.Errors.First().ExceptionMessage;
                }

                throw new PaymentGatewayException(PaymentGatewayCode.InternalError,
                    string.IsNullOrWhiteSpace(errorMessage)
                        ? PaymentGatewayCode.InternalError.ToDescription()
                        : errorMessage);
            }

            return new PaymentRecord()
            {
                PaymentIntentId = incrementPaymentTransition.PaymentIntentId,
                TerminalId = response.TerminalId,
                ChargeId = response.ApprovalNumber,
                HasCaptured = false,
                RefundedAmount = 0.00m,
                AmountRefunded = 0.00m,
                Last4 = response.AccountNumber[^4..],
                Brand = response.CardLogo,
                AuthCode = response.ApprovalNumber,
                PaidAmount = (decimal)response.TotalAmount,
                ChargeStatus = StripeChargeStatus.Succeeded,
            };
        }
        catch (Exception e)
        {
            Log.Error("Increment Authorization Rooster Pay Transaction error:{@e}", e);
            throw ExceptionExtensions.RoosterPayException(e);
        }
    }

    public async Task<PaymentRecord> CapturePaymentAsync(string payment, CancellationToken cancellationToken = default)
    {
        var capturePaymentTransition = JsonConvert.DeserializeObject<CapturePaymentTransition>(payment);
        if (capturePaymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var authorizationService = new AuthorizationService(triposClient);

        Log.Information(
            $"Rooster Pay Capture Transaction Id:{capturePaymentTransition.PaymentIntentId}, Terminal: {capturePaymentTransition.TerminalId}, Amount:{capturePaymentTransition.CaptureAmount}");
        try
        {
            var response = await authorizationService.UpdatePreviousCardAuthorizationCompletionAsync(
                capturePaymentTransition.PaymentIntentId,
                new(int.Parse(capturePaymentTransition.TerminalId),
                    (double)capturePaymentTransition.CaptureAmount)
                {
                    Configuration = new()
                    {
                        CheckForDuplicateTransactions = false,
                        AllowPartialApprovals = true,
                    },
                }, cancellationToken);

            Log.Information("Capture Rooster Pay Transaction Response:{@response}", response);

            if (response is not { IsApproved: true })
            {
                var errorMessage = response?.Processor?.ExpressResponseMessage;
                if (response?.Errors?.Count > 0)
                {
                    errorMessage = response.Errors.First().ExceptionMessage;
                }

                throw new PaymentGatewayException(PaymentGatewayCode.InternalError,
                    string.IsNullOrWhiteSpace(errorMessage)
                        ? PaymentGatewayCode.InternalError.ToDescription()
                        : errorMessage);
            }

            return new PaymentRecord()
            {
                PaymentIntentId = capturePaymentTransition.PaymentIntentId,
                TerminalId = response.TerminalId,
                ChargeId = response.TransactionId,
                HasCaptured = false,
                RefundedAmount = 0.00m,
                AmountRefunded = 0.00m,
                Last4 = response.AccountNumber[^4..],
                Brand = response.CardLogo,
                AuthCode = response.ApprovalNumber,
                Status = PaymentStatus.Captured,
                PaidAmount = (decimal)response.TotalAmount,
                ChargeStatus = StripeChargeStatus.Succeeded,
            };
        }
        catch (Exception e)
        {
            Log.Error("Capture Rooster Pay Transaction error:{@e}", e);
            throw ExceptionExtensions.RoosterPayException(e);
        }
    }

    public Task<PaymentRecord> ReAuthorizePaymentAsync(string chargeId, decimal amount,
        CancellationToken cancellationToken = default)
    {
        throw new PaymentGatewayException(PaymentGatewayCode.InternalError, "Not supported yet");
    }

    public Task<PaymentRecord> ConfirmAsync(string paymentIntentId, CancellationToken cancellationToken = default)
    {
        throw new PaymentGatewayException(PaymentGatewayCode.InternalError, "Not supported yet");
    }

    public async Task<PaymentRefundRecord> CreateRefundAsync(string payment,
        CancellationToken cancellationToken = default)
    {
        var paymentRefundTransition = JsonConvert.DeserializeObject<CreatePaymentRefundTransition>(payment);
        if (paymentRefundTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var returnService = new ReturnService(triposClient);

        try
        {
            var response = await returnService.CreateNewCardReturnAsync(
                new(int.Parse(paymentRefundTransition.TerminalId), (double)paymentRefundTransition.Amount),
                paymentRefundTransition.Type, paymentRefundTransition.PaymentIntentId, cancellationToken);

            if (response is not { IsApproved: true })
            {
                var errorMessage = response?.Processor?.ExpressResponseMessage;
                if (response?.Errors?.Count > 0)
                {
                    errorMessage = response.Errors.First().ExceptionMessage;
                }

                throw new PaymentGatewayException(PaymentGatewayCode.InternalError,
                    string.IsNullOrWhiteSpace(errorMessage)
                        ? PaymentGatewayCode.InternalError.ToDescription()
                        : errorMessage);
            }

            return new PaymentRefundRecord()
            {
                PaymentIntentId = paymentRefundTransition.PaymentIntentId,
                RefundId = response.TransactionId,
                Amount = (decimal)response.TotalAmount,
                Status = PaymentStatus.Captured
            };
        }
        catch (Exception e)
        {
            throw ExceptionExtensions.RoosterPayException(e);
        }
    }

    public async Task<PaymentRefundRecord> CancelRefundAsync(string payment,
        CancellationToken cancellationToken = default)
    {
        var paymentTransition = JsonConvert.DeserializeObject<CancelPaymentRefundTransition>(payment);
        if (paymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var voidService = new VoidService(triposClient);

        try
        {
            var response = await voidService.VoidPreviousTransactionAsync(new(int.Parse(paymentTransition.TerminalId)),
                paymentTransition.PaymentIntentId, cancellationToken).ConfigureAwait(false);

            if (response is not { IsApproved: true })
            {
                var errorMessage = response?.Processor?.ExpressResponseMessage;
                if (response?.Errors?.Count > 0)
                {
                    errorMessage = response.Errors.First().ExceptionMessage;
                }

                throw new PaymentGatewayException(PaymentGatewayCode.InternalError,
                    string.IsNullOrWhiteSpace(errorMessage)
                        ? PaymentGatewayCode.InternalError.ToDescription()
                        : errorMessage);
            }

            return new PaymentRefundRecord()
            {
                PaymentIntentId = paymentTransition.PaymentIntentId,
                RefundId = response.TransactionId,
                Status = PaymentStatus.Captured
            };
        }
        catch (Exception e)
        {
            throw ExceptionExtensions.RoosterPayException(e);
        }
    }

    public async Task<PaymentRefundRecord> GetRefundAsync(string payment, CancellationToken cancellationToken = default)
    {
        var paymentTransition = JsonConvert.DeserializeObject<GetPaymentTransition>(payment);
        if (paymentTransition == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var authorizationService = new TransactionQueryService(triposClient);

        try
        {
            var response = await authorizationService.TransactionQueryAsync(new("", "", "",
                    paymentTransition.StartTime.ToString("yyyy-MM-dd HH:mm:ss"),
                    paymentTransition.EndTime.ToString("yyyy-MM-dd HH:mm:ss"), paymentTransition.PaymentIntentId),
                cancellationToken);

            var transactionList = response.ReportingData;
            if (transactionList.Count == 0)
            {
                throw new PaymentGatewayException(PaymentGatewayCode.NotFoundError, "Transaction not found");
            }

            var transaction = transactionList
                .Where(x => CheckTransactionStatusSuccess(x.ExpressResponseCode))
                .OrderByDescending(x => $"{x.ExpressTransactionDate}${x.ExpressTransactionTime}").First();

            return new PaymentRefundRecord()
            {
                PaymentIntentId = transaction.TransactionId,
                RefundId = transaction.TransactionId,
                Amount = (decimal)transaction.TransactionAmount,
                Status = PaymentStatus.Captured
            };
        }
        catch (Exception e)
        {
            throw ExceptionExtensions.RoosterPayException(e);
        }
    }

    private bool CheckTransactionStatusSuccess(string expressResponseCode)
    {
        return expressResponseCode is "Success" or "Approved" or "PartialApproval";
    }

    private string SpacesToPascalCase(string text)
    {
        return string.IsNullOrWhiteSpace(text) ? string.Empty : MyRegex().Replace(text, " $1");
    }

    [GeneratedRegex("(?<!^)([A-Z])")]
    private static partial Regex MyRegex();
}
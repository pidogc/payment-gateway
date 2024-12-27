using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Exceptions;
using PaymentGateway.Extensions;
using PaymentGateway.Messages;
using Stripe;
using Stripe.Terminal;

namespace PaymentGateway.Strategy.StripePaymentStrategy;

public class StripeTerminalService(PaymentConfig config) : IPaymentTerminalService
{
    #region 处理支付

    public async Task<bool> ProcessTransitionAsync(
        string terminalId, string paymentIntentId, bool skipTipping = true, CancellationToken cancellation = default)
    {
        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);

        var readerService = new ReaderService(stripeClient);

        Reader reader = null;

        var attempt = 0;
        var tries = 3;
        while (true)
        {
            attempt++;
            try
            {
                reader = await readerService.ProcessPaymentIntentAsync(terminalId, new()
                {
                    PaymentIntent = paymentIntentId,
                    ProcessConfig = new()
                    {
                        SkipTipping = skipTipping,
                        EnableCustomerCancellation = true
                    },
                }, new() { ApiKey = config.PaymentProviderKey }, cancellation);

                return true;
            }
            catch (StripeException e)
            {
                switch (e.StripeError.Code)
                {
                    case "terminal_reader_timeout":
                        // 临时网络故障，自动重试 X 次
                        if (attempt == tries)
                            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, "Reader timeout");
                        break;

                    case "terminal_reader_offline":
                        // 读卡器处于脱机状态，不会响应API请求。请确保读卡器已打开电源并连接到互联网，然后重试。
                        throw new PaymentGatewayException(PaymentGatewayCode.InternalError, "Reader offline");

                    case "terminal_reader_busy":
                        // 读卡器正在忙, 在等待读卡器响应 API 请求的过程中，在应用程序中需要禁用支付按钮。
                        throw new PaymentGatewayException(PaymentGatewayCode.InternalError, "Reader busy");

                    case "intent_invalid_state":
                        // 检查 PaymentIntent 的状态，尚未准备好进行处理或者已经被成功处理或取消
                        var paymentIntentService = new PaymentIntentService(stripeClient)
                            .GetAsync(paymentIntentId, null, null, cancellation);

                        throw new PaymentGatewayException(PaymentGatewayCode.InternalError,
                            $"Payment is already in {paymentIntentService.Status} state");

                    case "terminal.reader.action_failed":
                        throw new PaymentGatewayException(PaymentGatewayCode.InternalError,
                            $"Payment is already in {reader?.Action.Status} state");

                    default:
                        throw new PaymentGatewayException(PaymentGatewayCode.InternalError, e.StripeError.Type);
                }
            }
        }
    }

    #endregion

    public async Task<ReaderMessage> AddAsync(string terminal, CancellationToken cancellation = default)
    {
        var addPaymentTerminal = JsonConvert.DeserializeObject<AddPaymentTerminalDto>(terminal);
        if (addPaymentTerminal == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());


        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);

        var readerService = new ReaderService(stripeClient);
        try
        {
            var reader = await readerService.CreateAsync(new()
            {
                RegistrationCode = addPaymentTerminal.Code,
                Location = config.LocationId,
                Label = string.IsNullOrWhiteSpace(addPaymentTerminal.Label)
                    ? config.SubjectName
                    : addPaymentTerminal.Label,
                Metadata = new()
                {
                    {
                        nameof(config.SubjectId), config.SubjectId
                    }
                }
            }, new() { ApiKey = config.PaymentProviderKey }, cancellation);

            return new ReaderMessage()
            {
                TerminalId = reader.Id,
                DeviceType = reader.DeviceType,
                Status = reader.ResolveReaderStatus(),
                Deleted = reader?.Deleted ?? false,
                Label = reader?.Label ?? ""
            };
        }
        catch (Exception e)
        {
            if (e.Message.Contains("Invalid param: registration_code"))
            {
                throw new PaymentGatewayException(PaymentGatewayCode.TerminalRegisterCodeError,
                    PaymentGatewayCode.TerminalRegisterCodeError.ToDescription());
            }

            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, e.Message);
        }
    }

    public async Task<ReaderMessage> UpdateAsync(string terminalId, string label,
        CancellationToken cancellation = default)
    {
        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var readerService = new ReaderService(stripeClient);

        try
        {
            var reader = await readerService.GetAsync(
                terminalId, null,
                new() { ApiKey = config.PaymentProviderKey }, cancellation);

            reader = await readerService.UpdateAsync(terminalId, new ReaderUpdateOptions()
            {
                Label = label
            }, new() { ApiKey = config.PaymentProviderKey }, cancellation);

            return new ReaderMessage()
            {
                TerminalId = reader.Id,
                DeviceType = reader.DeviceType,
                Status = reader.ResolveReaderStatus(),
                TransitionId = reader?.Action?.ProcessPaymentIntent?.PaymentIntentId ?? "",
                Deleted = reader?.Deleted ?? false,
                Label = reader?.Label ?? ""
            };
        }
        catch (Exception e)
        {
            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, e.Message);
        }
    }

    public async Task<ReaderMessage> GetAsync(string terminalId, CancellationToken cancellation = default)
    {
        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var readerService = new ReaderService(stripeClient);

        try
        {
            var reader = await readerService.GetAsync(
                terminalId, null,
                new() { ApiKey = config.PaymentProviderKey }, cancellation);

            return new ReaderMessage()
            {
                TerminalId = reader.Id,
                DeviceType = reader.DeviceType,
                Status = reader.ResolveReaderStatus(),
                TransitionId = reader?.Action?.ProcessPaymentIntent?.PaymentIntentId ?? "",
                Deleted = reader?.Deleted ?? false,
                Label = reader?.Label ?? "",
                ActionStatus = reader?.Action?.Status == "failed" ? ActionStatus.Failed : ActionStatus.Succeeded,
                ErrorMessage = reader?.Action?.FailureMessage ?? "",
            };
        }
        catch (Exception e)
        {
            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, e.Message);
        }
    }

    public Task<List<ReaderMessage>> AllAsync(CancellationToken cancellation = default)
    {
        return Task.FromResult(new List<ReaderMessage>());
    }

    public async Task<bool> DeleteAsync(string terminalId,
        CancellationToken cancellation = default)
    {
        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var readerService = new ReaderService(stripeClient);

        try
        {
            await readerService.DeleteAsync(
                terminalId, null,
                new() { ApiKey = config.PaymentProviderKey }, cancellation);

            return true;
        }
        catch (Exception e)
        {
            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, e.Message);
        }
    }

    public async Task<bool> CancelActionAsync(string terminalId, CancellationToken cancellation = default)
    {
        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var readerService = new ReaderService(stripeClient);

        try
        {
            await readerService.CancelActionAsync(terminalId, null, new() { ApiKey = config.PaymentProviderKey },
                cancellation);

            return true;
        }
        catch (Exception e)
        {
            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, e.Message);
        }
    }

    public async Task<bool> ConfigTipsAsync(bool tipsEnable, List<long?> tips, CancellationToken cancellation = default)
    {
        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var configurationService = new ConfigurationService(stripeClient);

        var configurations =
            await configurationService.ListAsync(null, new() { ApiKey = config.PaymentProviderKey },
                cancellation);

        foreach (var configuration in configurations)
        {
            await configurationService.UpdateAsync(configuration.Id, new()
            {
                Offline = new()
                {
                    Enabled = false
                }
            }, null, cancellation);
        }

        if (!tipsEnable) return true;

        var conf = await configurationService.CreateAsync(new()
        {
            Offline = new()
            {
                Enabled = false
            },
            Tipping = new()
            {
                Usd = new()
                {
                    Percentages = tips
                }
            },
        }, null, cancellation);

        var locationService = new LocationService(stripeClient);
        await locationService.UpdateAsync(
            config.LocationId,
            new()
            {
                DisplayName = config.SubjectName,
                ConfigurationOverrides = conf.Id
            }, null, cancellation);

        return true;
    }

    public async Task<ReaderMessage> PresentPaymentMethodAsync(string terminalId,
        CancellationToken cancellation = default)
    {
        var stripeClient = new StripeClient(apiKey: config.PaymentProviderKey);
        var readerService = new Stripe.TestHelpers.Terminal.ReaderService(stripeClient);

        try
        {
            var reader = await readerService.PresentPaymentMethodAsync(terminalId, null, null, cancellation)
                .ConfigureAwait(false);

            return new ReaderMessage()
            {
                TerminalId = reader.Id,
                DeviceType = reader.DeviceType,
                Status = reader.ResolveReaderStatus(),
                TransitionId = reader?.Action?.ProcessPaymentIntent?.PaymentIntentId ?? "",
                Deleted = reader?.Deleted ?? false,
                Label = reader?.Label ?? ""
            };
        }
        catch (Exception e)
        {
            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, e.Message);
        }
    }
}
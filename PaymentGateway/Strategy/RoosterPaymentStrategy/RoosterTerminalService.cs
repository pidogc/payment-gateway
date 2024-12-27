using Newtonsoft.Json;
using PaymentGateway.Domains;
using PaymentGateway.Dto;
using PaymentGateway.Exceptions;
using PaymentGateway.Extensions;
using PaymentGateway.Messages;
using PaymentGateway.Settings;
using Tripos;
using Tripos.Exceptions;
using Tripos.Service.Idle;
using Tripos.Service.Lanes;

namespace PaymentGateway.Strategy.RoosterPaymentStrategy;

public class RoosterTerminalService(PaymentConfig config, RoosterPaySetting roosterPaySetting) : IPaymentTerminalService
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

    public Task<bool> ProcessTransitionAsync(string terminalId, string paymentIntentId, bool skipTipping = true,
        CancellationToken cancellation = default)
    {
        throw new PaymentGatewayException(PaymentGatewayCode.InternalError, "Not supported yet");
    }

    public async Task<ReaderMessage> AddAsync(string terminal, CancellationToken cancellation = default)
    {
        var addPaymentTerminal = JsonConvert.DeserializeObject<AddPaymentTerminalDto>(terminal);
        if (addPaymentTerminal == null)
            throw new PaymentGatewayException(PaymentGatewayCode.ParameterError,
                PaymentGatewayCode.ParameterError.ToDescription());

        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var lanesService = new LanesService(triposClient);

        try
        {
            var laneResponse = await lanesService.CreateAsync(new(
                int.Parse(addPaymentTerminal.id),
                addPaymentTerminal.id,
                addPaymentTerminal.Code
            ), cancellation);

            if (laneResponse.LaneId > 0)
            {
                return new ReaderMessage()
                {
                    TerminalId = addPaymentTerminal.id,
                    DeviceType = laneResponse.ModelNumber,
                    Status = ReaderStatus.Offline,
                    Deleted = false,
                    Label = laneResponse.TerminalId
                };
            }

            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, "Add terminal error");
        }
        catch (Exception e)
        { 
            throw ExceptionExtensions.RoosterPayException(e);
        }
    }

    public async Task<ReaderMessage> UpdateAsync(string terminalId, string label,
        CancellationToken cancellation = default)
    {
        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var lanesService = new LanesService(triposClient);
        var laneId = int.Parse(terminalId);

        try
        {
            await lanesService.UpdateAsync(laneId, new() { }, cancellation);

            var laneResponse = await lanesService.GetLaneConnectionStatusAsync(laneId, cancellation);

            return new ReaderMessage()
            {
                TerminalId = terminalId,
                Status = laneResponse.Status == "Open" ? ReaderStatus.Online : ReaderStatus.Offline
            };
        }
        catch (Exception e)
        {
            throw ExceptionExtensions.RoosterPayException(e);
        }
    }

    /**
     * status: Open、Closed
     */
    public async Task<ReaderMessage> GetAsync(string terminalId, CancellationToken cancellation = default)
    {
        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var lanesService = new LanesService(triposClient);
        try
        {
            var laneConnectionStatus =
                await lanesService.GetLaneConnectionStatusAsync(int.Parse(terminalId), cancellation);
            return new ReaderMessage()
            {
                TerminalId = terminalId,
                Status = laneConnectionStatus.Status == "Open" ? ReaderStatus.Online : ReaderStatus.Offline
            };
        }
        catch (Exception e)
        {
            throw ExceptionExtensions.RoosterPayException(e);
        }
    }

    public async Task<List<ReaderMessage>> AllAsync(CancellationToken cancellation = default)
    {
        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var lanesService = new LanesService(triposClient);
        try
        {
            var lanes = await lanesService.ListAsync(cancellationToken: cancellation);
            List<ReaderMessage> readerMessages = [];

            readerMessages.AddRange(lanes.Select(lane => new ReaderMessage()
            {
                TerminalId = lane.LaneId.ToString(),
                DeviceType = lane?.ModelNumber ?? "",
                Status = ReaderStatus.Offline,
                Deleted = false,
                Label = lane?.TerminalId ?? ""
            }));

            return readerMessages;
        }
        catch (Exception e)
        {
            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, e.Message);
        }
    }

    public async Task<bool> DeleteAsync(string terminalId, CancellationToken cancellation = default)
    {
        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var lanesService = new LanesService(triposClient);
        try
        {
            await lanesService.DeleteAsync(int.Parse(terminalId), cancellation);
            return true;
        }
        catch (HttpClientException ex) when (ex.Code == 404)
        {
            return true; // 404未找到刷卡机也算删除成功，返回到外面删除刷卡机
        }
        catch (Exception e)
        {
            throw ExceptionExtensions.RoosterPayException(e);
        }
    }

    public async Task<bool> CancelActionAsync(string terminalId, CancellationToken cancellation = default)
    {
        var triposClient = GetTriposClient(config.PaymentProviderKey, config.LocationId, config.PaymentProviderSecret);
        var idleService = new IdleService(triposClient);
        try
        {
            await idleService.IdleScreenAsync(int.Parse(terminalId), cancellation);
            return true;
        }
        catch (Exception e)
        {
            throw new PaymentGatewayException(PaymentGatewayCode.InternalError, e.Message);
        }
    }

    public Task<bool> ConfigTipsAsync(bool tipsEnable, List<long?> tips, CancellationToken cancellation = default)
    {
        return Task.FromResult(true);
    }

    public Task<ReaderMessage> PresentPaymentMethodAsync(string terminalId,
        CancellationToken cancellation = default)
    {
        throw new NotImplementedException();
    }
}
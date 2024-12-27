using System.ComponentModel;

namespace PaymentGateway.Messages;

public class PaymentMessage<T>
{
    public int Code { get; set; }
    public string Msg { get; set; }
    public T Data { get; set; }
}

public class ReaderMessage
{
    public string TerminalId { get; set; }
    public string DeviceType { get; set; }
    public ReaderStatus Status { get; set; }
    public string TransitionId { get; set; } = "";
    public bool Deleted { get; set; }
    public string Label { get; set; } = "";
    public ActionStatus ActionStatus { get; set; } = ActionStatus.Succeeded;
    public string ErrorMessage { get; set; } = "";
}

public enum ActionStatus
{
    [Description("Successed")] Succeeded,
    [Description("Failed")] Failed,
}

public enum ReaderStatus
{
    [Description("")] UnKnow,
    [Description("online")] Online,
    [Description("offline")] Offline,
    [Description("in_progress")] InProgress,
    [Description("succeeded")] Succeeded,
    [Description("failed")] Failed
}
using PaymentGateway.Infrastructure;
using PaymentGateway.Strategy;

namespace PaymentGateway.Domains;

public partial class PaymentConfig : PaymentAuditedEntity, IPaymentGatewaySoftDelete
{
    /// <summary>
    /// 商家 id ( MerchantId )
    /// </summary>
    public string SubjectId { get; set; }
    /// <summary>
    /// 商家名称
    /// </summary>
    public string SubjectName { get; set; }
    /// <summary>
    /// 支付商的 key
    /// </summary>
    public string PaymentProviderKey { get; set; }
    /// <summary>
    /// 支付商的 secret
    /// </summary>
    public string PaymentProviderSecret { get; set; }
    /// <summary>
    /// 支付商的 LocationId
    /// </summary>
    public string LocationId { get; set; }
    /// <summary>
    /// 本支付程序的 key, 用于授权调用
    /// </summary>
    public string AppId { get; set; }
    /// <summary>
    /// 本支付程序的 secret, 用于授权调用
    /// </summary>
    public string AppSecret { get; set; }

    public PaymentSolutionType SolutionType { get; set; }

    public bool IsDelete { get; set; }
}


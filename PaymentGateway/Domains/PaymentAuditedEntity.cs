using System.ComponentModel.DataAnnotations;

namespace PaymentGateway.Domains;

public class PaymentAuditedEntity
{
    [Key]
    public string Id { get; set; }
    public DateTimeOffset CreateAt { get; set; } = DateTimeOffset.UtcNow;
    public DateTimeOffset UpdateAt { get; set; } = DateTimeOffset.UtcNow;
}
using PaymentGateway.Domains;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace PaymentGateway.Mappings;

public class PaymentConfigMapping : IEntityTypeConfiguration<PaymentConfig>
{
    public void Configure(EntityTypeBuilder<PaymentConfig> builder)
    {
        // Primary Key & Index
        builder.HasKey(x => x.Id);
        builder.HasIndex(x => new { x.AppId, x.AppSecret }).IsUnique();

        builder.Property(x => x.Id).HasMaxLength(36).IsRequired();
        builder.Property(x => x.SubjectId).HasMaxLength(36).IsRequired();
        builder.Property(x => x.SubjectName).HasMaxLength(20).IsRequired();
        builder.Property(x => x.AppId).HasMaxLength(128).IsRequired();
        builder.Property(x => x.AppSecret).HasMaxLength(128).IsRequired();
        builder.Property(x => x.LocationId).HasMaxLength(128).IsRequired();
        builder.Property(x => x.PaymentProviderKey).HasMaxLength(255).IsRequired();
        builder.Property(x => x.PaymentProviderSecret).HasMaxLength(255).HasDefaultValue("");
        builder.Property(x => x.SolutionType);
        builder.Property(x => x.IsDelete).HasColumnType("bit").HasDefaultValue(false);
        
        // Table & Column Mappings
        builder.ToTable("payment_gateway_payment_config");
        
        builder.Property(t => t.Id).HasColumnName("id");
        builder.Property(t => t.CreateAt).HasColumnName("create_at");
        builder.Property(t => t.UpdateAt).HasColumnName("update_at");
        
        builder.Property(x => x.SubjectId).HasColumnName("subject_id");
        builder.Property(x => x.SubjectName).HasColumnName("subject_name");
        builder.Property(x => x.AppId).HasColumnName("app_id");
        builder.Property(x => x.AppSecret).HasColumnName("app_secret");
        builder.Property(x => x.LocationId).HasColumnName("location_id");
        builder.Property(x => x.PaymentProviderKey).HasColumnName("payment_provider_key");
        builder.Property(x => x.PaymentProviderSecret).HasColumnName("payment_provider_secret");
        builder.Property(x => x.SolutionType).HasColumnName("solution_type");
        builder.Property(t => t.IsDelete).HasColumnName("is_delete");
    }
}
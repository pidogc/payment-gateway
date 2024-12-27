using Microsoft.EntityFrameworkCore;
using PaymentGateway.Extensions;
using PaymentGateway.Infrastructure;

namespace PaymentGateway.Domains;

public partial class PaymentConfig
{
    public async Task<PaymentConfig> LoadAsync(IPaymentRepository repository, CancellationToken cancellation = default)
    {
        PaymentConfig paymentConfig;

        var queryable = repository.Query<PaymentConfig>();
        if (!string.IsNullOrWhiteSpace(SubjectId))
        {
            paymentConfig = await queryable.SingleOrDefaultAsync(x => x.SubjectId == SubjectId, cancellation);
            if (paymentConfig == null)
                throw new Exception("PaymentConfig not found");

            return paymentConfig;
        }

        if (string.IsNullOrWhiteSpace(AppId) || string.IsNullOrWhiteSpace(AppSecret))
            throw new Exception("PaymentConfig not found");

        paymentConfig =
            await queryable.SingleOrDefaultAsync(x => x.AppId == AppId && x.AppSecret == AppSecret, cancellation);

        if (paymentConfig == null)
            throw new Exception("PaymentConfig not found");

        paymentConfig.PaymentProviderKey =
            AesEncryptionExtensions.Decrypt(paymentConfig.PaymentProviderKey, paymentConfig.SubjectId);
        paymentConfig.PaymentProviderSecret =
            AesEncryptionExtensions.Decrypt(paymentConfig.PaymentProviderSecret, paymentConfig.SubjectId);

        return paymentConfig;
    }

    public async Task<PaymentConfig?> SingOrDefaultAsync(IPaymentRepository repository,
        CancellationToken cancellation = default)
    {
        return await repository.Query<PaymentConfig>()
            .SingleOrDefaultAsync(x => x.AppId == AppId && x.AppSecret == AppSecret, cancellation);
    }

    public async Task<PaymentConfig> SaveAsync(IPaymentRepository repository, CancellationToken cancellation = default,
        IMessageQueue? mq = null)
    {
        PaymentProviderKey = AesEncryptionExtensions.Encrypt(PaymentProviderKey, SubjectId);
        PaymentProviderSecret = AesEncryptionExtensions.Encrypt(PaymentProviderSecret, SubjectId);
        if (string.IsNullOrWhiteSpace(Id))
            await repository.InsertAsync(this, cancellation);
        else
            await repository.UpdateAsync(this, cancellation);

        if (mq != null)
            await mq.PublishAsync(this, cancellation);
        return this;
    }

    public async Task<PaymentConfig> DeleteAsync(IPaymentRepository repository,
        CancellationToken cancellation = default, IMessageQueue? mq = null)
    {
        await repository.DeleteAsync(this, cancellation);
        if (mq != null)
            await mq.PublishAsync(this, cancellation);
        return this;
    }
}
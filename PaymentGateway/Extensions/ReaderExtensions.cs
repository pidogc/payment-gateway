using PaymentGateway.Messages;
using Stripe.Terminal;

namespace PaymentGateway.Extensions;

public static class ReaderExtensions
{
    public static ReaderStatus ResolveReaderStatus(this Reader reader)
    {
        return reader.Deleted is true ? ReaderStatus.Offline : reader.Status.ToEnum<ReaderStatus>();
    }
}
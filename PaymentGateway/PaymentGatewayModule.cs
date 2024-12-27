using Autofac;
using CoRProcessor;
using Microsoft.Extensions.Configuration;
using PaymentGateway.Infrastructure;
using PaymentGateway.Messages;
using PaymentGateway.PaymentGatewaySQL.ScriptRunner;
using PaymentGateway.Services;
using PaymentGateway.Settings;

namespace PaymentGateway;

public class PaymentGatewayModule(IConfiguration configuration, string mySqlConnectionString) : Module
{
    protected override void Load(ContainerBuilder builder)
    {
        RegisterCoR(builder);
        RegisterDbUp(builder);
        RegisterService(builder);
        RegisterSetting(builder);
    }

    private void RegisterService(ContainerBuilder builder)
    {
        foreach (var type in typeof(PaymentGatewayModule).Assembly.GetTypes()
                     .Where(t => typeof(IPaymentGatewayService).IsAssignableFrom(t) && t.IsClass))
        {
            builder.RegisterType(type).AsImplementedInterfaces().InstancePerLifetimeScope();
        }
    }

    private void RegisterCoR(ContainerBuilder builder)
    {
        builder.AddCoR(typeof(PaymentGatewayModule).Assembly);
    }

    private void RegisterDbUp(ContainerBuilder builder)
    {
        builder.RegisterInstance(new FileSystemMySqlDbUpScriptRunner(mySqlConnectionString)).AsImplementedInterfaces();
    }

    public static void RegisterRepository<T>(ContainerBuilder builder) where T : IPaymentRepository
    {
        builder.RegisterType<T>().As<IPaymentRepository>().AsImplementedInterfaces()
            .InstancePerLifetimeScope();
    }

    private void RegisterSetting(ContainerBuilder builder)
    {
        builder.RegisterInstance(new RoosterPaySetting(configuration)).SingleInstance();
    }
}
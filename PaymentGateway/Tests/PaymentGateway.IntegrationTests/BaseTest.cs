using Autofac;
using Autofac.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using PaymentGateway.IntegrationTests.Data;

namespace PaymentGateway.IntegrationTests;

public class BaseTest : TestUtilBase
{
    protected IHost Host;
    protected IServiceScope Scope;

    [OneTimeSetUp]
    public virtual void OneTimeSetUp()
    {
        var builder = Microsoft.Extensions.Hosting.Host.CreateDefaultBuilder();
        builder.ConfigureAppConfiguration((context, config) =>
            {
                config.AddJsonFile("appsettings.json").AddEnvironmentVariables();
                context.HostingEnvironment.EnvironmentName = "Test";
            })
            .UseServiceProviderFactory(new AutofacServiceProviderFactory())
            .ConfigureContainer<ContainerBuilder>((context, containerBuilder) =>
            {
                var connectionString = context.Configuration.GetValue<string>("ConnectionStrings:Mysql");
                containerBuilder.RegisterModule(new PaymentGatewayModule(context.Configuration, connectionString));
                PaymentGatewayModule.RegisterRepository<TestPaymentGatewayRepository>(containerBuilder);
                containerBuilder.RegisterInstance(new IdGenerator(1)).SingleInstance();
                containerBuilder.RegisterType<TestPaymentGatewayDbContext>()
                    .AsSelf()
                    .As<DbContext>()
                    .As<TestPaymentGatewayDbContext>()
                    .AsImplementedInterfaces()
                    .InstancePerLifetimeScope();
            });


        // Environment.SetEnvironmentVariable("ASPNETCORE_ENVIRONMENT", "Test");

        Host = builder.Build();
        Scope = Host.Services.CreateScope();
        var scope = Scope.ServiceProvider.GetRequiredService<ILifetimeScope>();
        var lifetimeScope = scope.BeginLifetimeScope();
        SetupScope(lifetimeScope);
    }

    protected T GetService<T>()
    {
        return Scope.ServiceProvider.GetRequiredService<T>();
    }

    [SetUp]
    public void InitDataBase()
    {
        Scope.ServiceProvider.GetRequiredService<DbContext>().Database.EnsureDeleted();
        Scope.ServiceProvider.GetRequiredService<DbContext>().Database.EnsureCreated();
    }

    [SetUp]
    public virtual void SetUp()
    {
    }
}
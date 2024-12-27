using Microsoft.Extensions.Configuration;

namespace PaymentGateway.Settings;

public class RoosterPaySetting(IConfiguration configuration)
{
    public string Url { get; } = configuration.GetValue<string>("RoosterPaySetting:Url") ?? "https://triposcert.vantiv.com";
    public string ApplicationId { get; } = configuration.GetValue<string>("RoosterPaySetting:ApplicationId") ?? "9527";
    public string ApplicationName { get; } = configuration.GetValue<string>("RoosterPaySetting:ApplicationName") ?? "EasyPos";
    public string ApplicationVersion { get; } = configuration.GetValue<string>("RoosterPaySetting:ApplicationVersion") ?? "1.0.6";
}
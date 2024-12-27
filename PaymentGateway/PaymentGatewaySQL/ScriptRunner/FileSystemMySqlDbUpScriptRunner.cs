using Autofac;
using DbUp;
using DbUp.Engine;

namespace PaymentGateway.PaymentGatewaySQL.ScriptRunner;

public class FileSystemMySqlDbUpScriptRunner(string mySqlConnectionString) : IStartable
{
    public void Start()
    {
        var baseDirectory = Path.GetDirectoryName(typeof(PaymentGatewayModule).Assembly.Location);
        // 确定脚本文件的路径
        var scriptFolderPath = Path.Combine(baseDirectory, "PaymentGatewaySQL");

        var upgrade = DeployChanges.To
            .MySqlDatabase(mySqlConnectionString)
            .WithPreprocessor(new MySqlScriptPreprocessor())
            .WithScripts(GetScripts(scriptFolderPath))
            .WithTransaction()
            .LogToConsole()
            .Build();

        var result = upgrade.PerformUpgrade();

        if (!result.Successful)
        {
            throw new Exception("DbUp failed for FileSystemMySqlDbUpScriptRunner", result.Error);
        }
    }

    private IEnumerable<SqlScript> GetScripts(string scriptFolderPath)
    {
        var scripts = new List<SqlScript>();

        foreach (var scriptFile in Directory.GetFiles(scriptFolderPath, "*.sql"))
        {
            var scriptName = "PaymentGateway.SQL." + Path.GetFileName(scriptFile);
            var scriptContents = File.ReadAllText(scriptFile);
            scripts.Add(new SqlScript(scriptName, scriptContents));
        }

        return scripts;
    }
}

public class MySqlScriptPreprocessor : IScriptPreprocessor
{
    public string Process(string contents) => contents.Replace("\\'", "`");
}
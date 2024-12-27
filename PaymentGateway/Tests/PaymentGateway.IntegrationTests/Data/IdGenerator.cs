using Yitter.IdGenerator;

namespace PaymentGateway.IntegrationTests.Data;

public class IdGenerator
{
    private static Queue<long> queue = new();

    public IdGenerator(ushort workId = 1)
    {
        var options = new IdGeneratorOptions(workId)
        {
            SeqBitLength = 10
        };
        YitIdHelper.SetIdGenerator(options);
        // GeneratorSnowflake();
    }

    public long NewAsync()
    {
        return YitIdHelper.NextId();
    }

    public long New()
    {
        lock (queue)
        {
            // if (queue.Count <= 5000)
            // {
            //     GeneratorSnowflake();
            // }

            return YitIdHelper.NextId();
        }
    }
    
    public string NewString()
    {
        lock (queue)
        {
            return $"{YitIdHelper.NextId()}";
        }
    }


    private void GeneratorSnowflake()
    {
        for (var i = 0; i <= 50000; i++)
        {
            queue.Enqueue(YitIdHelper.NextId());
        }
    }
}
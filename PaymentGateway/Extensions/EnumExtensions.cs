using System.ComponentModel;

namespace PaymentGateway.Extensions;

public static class EnumExtensions
{
    public static string ToDescription(this Enum value)
    {
        var field = value.GetType().GetField(value.ToString());

        if (field != null)
        {
            var attribute =
                (DescriptionAttribute)System.Attribute.GetCustomAttribute(field, typeof(DescriptionAttribute));

            if (attribute != null)
            {
                return attribute.Description;
            }
        }

        return value.ToString();
    }

    public static T ToEnum<T>(this string value)
    {
        foreach (var field in typeof(T).GetFields())
        {
            if (System.Attribute.GetCustomAttribute(field, typeof(DescriptionAttribute)) is not DescriptionAttribute
                attribute) continue;
            if (attribute.Description.Equals(value, StringComparison.CurrentCultureIgnoreCase))
            {
                return (T)field.GetValue(null);
            }
        }

        throw new ArgumentException($"No matching enum value for description: {value}");
    }
}

public static class StringExtensions
{
    public static string SplitBy(this string str, char separator)
    {
        return string.Concat(str.AsSpan(0, (str.Contains(separator) ? str.IndexOf(separator) : str.Length)),
            str.Contains(separator) ? "." : "");
    }
}
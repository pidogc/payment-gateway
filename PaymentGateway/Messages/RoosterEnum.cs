namespace PaymentGateway.Messages;

public static class RoosterSelectionFormType
{
    public const string MultiOption = "MultiOption";
    public const string MultiOptionTextArea = "MultiOptionTextArea"; // 只支持Mx915、Mx925，Move 5000不支持
    public const string YesNoTextArea = "YesNoTextArea";
}

public static class RoosterInputPromptType
{
    public const string Tip = "Tip";
    public const string Cashback = "Cashback";
    public const string Amount = "Amount";
    public const string Zip = "Zip";
    public const string Phone = "Phone";
    public const string EasyPayCode = "EasyPayCode";
    public const string Data = "Data";
    public const string ServerId = "ServerId";
    public const string CheckNumber = "CheckNumber";
    public const string TableNumber = "TableNumber";
}

public static class RoosterInputFormatType
{
    public const string None = "None";
    public const string AmountWithComma = "AmountWithComma";
    public const string AmountWithDollarComma = "AmountWithDollarComma";
    public const string AmountWithDollarCommaDecimal = "AmountWithDollarCommaDecimal";
    public const string PhoneWithAreaCodeSeparatorAndDashes = "PhoneWithAreaCodeSeparatorAndDashes";
    public const string AllowLeadingZero = "AllowLeadingZero";
}
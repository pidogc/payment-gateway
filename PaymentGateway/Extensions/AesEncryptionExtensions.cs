using System.Security.Cryptography;
using System.Text;
using Serilog;

namespace PaymentGateway.Extensions;

public static class AesEncryptionExtensions
{
    public static byte[] GetKeyBytes(string key)
    {
        return SHA256.HashData(Encoding.UTF8.GetBytes(key));
    }

    public static string Encrypt(string plainText, string subjectId)
    {
        try
        {
            if (string.IsNullOrEmpty(plainText) || string.IsNullOrEmpty(subjectId)) return "";

            var keyBytes = GetKeyBytes(subjectId);

            using var aesAlg = Aes.Create();
            aesAlg.Key = keyBytes;
            aesAlg.GenerateIV();

            var encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

            using var msEncrypt = new MemoryStream();
            using (var csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
            {
                using (var swEncrypt = new StreamWriter(csEncrypt))
                {
                    swEncrypt.Write(plainText);
                }
            }

            var ivBytes = aesAlg.IV;
            var encryptedBytes = msEncrypt.ToArray();
            var resultBytes = new byte[ivBytes.Length + encryptedBytes.Length];
            Buffer.BlockCopy(ivBytes, 0, resultBytes, 0, ivBytes.Length);
            Buffer.BlockCopy(encryptedBytes, 0, resultBytes, ivBytes.Length, encryptedBytes.Length);

            var res =  Convert.ToBase64String(resultBytes);
            return res;
        }
        catch (Exception ex)
        {
            Log.Error($"encrypt plainText fail, plainText: {plainText}, {subjectId}", ex);
            return plainText;
        }
    }

    public static string Decrypt(string cipherText, string subjectId)
    {
        try
        {
            if (string.IsNullOrEmpty(cipherText) || string.IsNullOrEmpty(subjectId)) return "";

            var keyBytes = GetKeyBytes(subjectId);
            var cipherBytes = Convert.FromBase64String(cipherText);

            using Aes aesAlg = Aes.Create();
            aesAlg.Key = keyBytes;

            var ivBytes = new byte[aesAlg.BlockSize / 8];
            Buffer.BlockCopy(cipherBytes, 0, ivBytes, 0, ivBytes.Length);
            aesAlg.IV = ivBytes;

            var cryptoTransform = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

            using var msDecrypt = new MemoryStream(cipherBytes, ivBytes.Length, cipherBytes.Length - ivBytes.Length);
            using var csDecrypt = new CryptoStream(msDecrypt, cryptoTransform, CryptoStreamMode.Read);
            using var srDecrypt = new StreamReader(csDecrypt);
            return srDecrypt.ReadToEnd();
        }
        catch (Exception ex)
        {
            Log.Error($"decrypt cipherText fail, cipherText: {cipherText}, {subjectId}", ex);
            return cipherText;
        }
    }
}
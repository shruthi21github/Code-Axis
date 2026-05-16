package codeaxis.api.utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.HexFormat;

public class Sha256Util
{
    public static String hash(String value)
    {
        try
        {
            MessageDigest digest =
                MessageDigest.getInstance("SHA-256");

            byte[] hash =
                digest.digest(
                    value.getBytes(StandardCharsets.UTF_8)
                );

            return HexFormat
                .of()
                .formatHex(hash);
        }
        catch (Exception ex)
        {
            throw new RuntimeException(ex);
        }
    }
}
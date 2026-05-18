package com.codeaxis.utils;

import java.nio.ByteBuffer;
import java.util.UUID;

public class UuidUtil {
    public static byte[] uuidToBytes(UUID uuid) {
        byte[] bytes = new byte[16];

        ByteBuffer byteBuffer = ByteBuffer.wrap(bytes);

        byteBuffer.putLong(
                uuid.getMostSignificantBits());

        byteBuffer.putLong(
                uuid.getLeastSignificantBits());

        return bytes;
    }
}

package com.codeaxis.utils;

import com.github.f4b6a3.uuid.UuidCreator;

import java.nio.ByteBuffer;
import java.util.UUID;

public class UuidUtil {

    /*
     * ===============================================================
     * PRIVATE CONSTRUCTOR
     * ===============================================================
     */

    private UuidUtil() {
    }

    /*
     * ===============================================================
     * GENERATE TIME ORDERED UUID
     * ===============================================================
     */

    public static UUID generateUUID() {

        return UuidCreator.getTimeOrderedEpoch();
    }

    /*
     * ===============================================================
     * CONVERT UUID TO BYTE ARRAY
     * ===============================================================
     */

    public static byte[] uuidToBytes(
            UUID uuid) {

        byte[] bytes = new byte[16];

        ByteBuffer byteBuffer =
                ByteBuffer.wrap(bytes);

        byteBuffer.putLong(
                uuid.getMostSignificantBits());

        byteBuffer.putLong(
                uuid.getLeastSignificantBits());

        return bytes;
    }
}
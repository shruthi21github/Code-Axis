package com.codeaxis.rolebasedaccess.utils;

import com.github.f4b6a3.uuid.UuidCreator;

import java.util.UUID;

public class UuidUtil {

    private UuidUtil() {
    }

    public static UUID generateUUID() {

        return UuidCreator.getTimeOrderedEpoch();
    }
}
package com.codeaxis.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordUtil {

    public static void main(String[] args) {

        BCryptPasswordEncoder encoder =
                new BCryptPasswordEncoder();

        String hashedPassword =
                encoder.encode("admin123");

        System.out.println(hashedPassword);
    }
}
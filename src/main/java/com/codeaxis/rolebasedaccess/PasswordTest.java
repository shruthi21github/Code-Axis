package com.codeaxis.rolebasedaccess;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordTest {

    public static void main(String[] args) {

        BCryptPasswordEncoder encoder =
                new BCryptPasswordEncoder();

        String rawPassword = "admin123";

        String encodedPassword =
                encoder.encode(rawPassword);

        System.out.println(
                "ENCODED PASSWORD:"
        );

        System.out.println(encodedPassword);

        System.out.println(
                "MATCH RESULT:"
        );

        System.out.println(
                encoder.matches(
                        rawPassword,
                        encodedPassword
                )
        );
    }
}
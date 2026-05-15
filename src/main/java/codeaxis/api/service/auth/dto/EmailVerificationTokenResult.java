package codeaxis.api.service.auth.dto;

import codeaxis.api.entity.EmailVerificationToken;

public class EmailVerificationTokenResult {

    private final String rawToken;

    private final EmailVerificationToken
            emailVerificationToken;

    public EmailVerificationTokenResult(
            String rawToken,

            EmailVerificationToken
                    emailVerificationToken) {

        this.rawToken =
                rawToken;

        this.emailVerificationToken =
                emailVerificationToken;
    }

    public String getRawToken() {
        return rawToken;
    }

    public EmailVerificationToken
            getEmailVerificationToken() {

        return emailVerificationToken;
    }
}

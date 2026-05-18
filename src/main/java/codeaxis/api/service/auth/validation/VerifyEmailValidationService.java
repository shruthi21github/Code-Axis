package codeaxis.api.service.auth.validation;

import java.time.LocalDateTime;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import codeaxis.api.entity.EmailVerificationToken;
import codeaxis.api.entity.User;
import codeaxis.api.exception.ApiException;
import codeaxis.api.repository.EmailVerificationTokenRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor

public class VerifyEmailValidationService {

    private final EmailVerificationTokenRepository emailVerificationTokenRepository;

    /*
     * ===========================================================================
     * VALIDATE TOKEN
     * ===========================================================================
     */

    public EmailVerificationToken validateAndGetToken(
            String tokenHash) {

        EmailVerificationToken token = emailVerificationTokenRepository
                .findByVerificationTokenHashAndIsActiveTrueAndExpiresAtAfter(
                        tokenHash,
                        LocalDateTime.now())
                .orElseThrow(
                        () -> new ApiException(
                                HttpStatus.BAD_REQUEST,
                                "Invalid or expired verification token"));

        return token;
    }

    /*
     * ===========================================================================
     * VALIDATE USER EMAIL STATUS
     * ===========================================================================
     */

    public void validateUserNotAlreadyVerified(
            User user) {

        if (Boolean.TRUE.equals(
                user.getIsEmailVerified())) {

            throw new ApiException(
                    HttpStatus.CONFLICT,
                    "Email already verified");
        }
    }
}

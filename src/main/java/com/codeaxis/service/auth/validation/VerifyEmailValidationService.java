package com.codeaxis.service.auth.validation;

import java.time.LocalDateTime;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.codeaxis.entity.EmailVerificationToken;
import com.codeaxis.entity.User;
import com.codeaxis.exception.ApiException;
import com.codeaxis.repository.EmailVerificationTokenRepository;

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

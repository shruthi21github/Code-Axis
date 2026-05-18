package com.codeaxis.service.auth;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.codeaxis.dto.auth.RegisterRequestDto;
import com.codeaxis.dto.auth.RegisterResponseDto;
import com.codeaxis.entity.Role;
import com.codeaxis.entity.User;
import com.codeaxis.repository.EmailVerificationTokenRepository;
import com.codeaxis.repository.UserRepository;
import com.codeaxis.service.auth.dto.EmailVerificationTokenResult;
import com.codeaxis.service.auth.factory.EmailVerificationTokenFactory;
import com.codeaxis.service.auth.factory.UserFactory;
import com.codeaxis.service.auth.mapper.RegisterResponseMapper;
import com.codeaxis.service.auth.validation.RegisterValidationService;
import com.codeaxis.service.mail.EmailService;
import com.codeaxis.service.mail.dto.SendEmailRequestDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor

public class RegisterService {

    private final UserRepository userRepository;

    private final EmailVerificationTokenRepository emailVerificationTokenRepository;

    private final RegisterValidationService registerValidationService;

    private final UserFactory userFactory;

    private final EmailVerificationTokenFactory emailVerificationTokenFactory;

    private final RegisterResponseMapper registerResponseMapper;

    private final EmailService emailService;

    /*
     * =============================================================================
     * FRONTEND APPLICATION URL CONFIGURATION
     * =============================================================================
     */

    @Value("${app.frontend.base-url}")
    private String frontendBaseUrl;

    @Value("${app.frontend.verify-email-path}")
    private String verifyEmailPath;

    /*
     * =============================================================================
     * REGISTER USER
     * =============================================================================
     */

    @Transactional
    public RegisterResponseDto register(
            RegisterRequestDto request) {

        /*
         * ===========================================================================
         * NORMALIZE INPUT
         * ===========================================================================
         */

        String username = request.getUsername()
                .trim()
                .toLowerCase();

        String email = request.getEmail()
                .trim()
                .toLowerCase();

        String roleName = request.getRoleName()
                .trim()
                .toUpperCase();

        /*
         * ===========================================================================
         * VALIDATE REGISTRATION DATA
         * ===========================================================================
         */

        registerValidationService
                .validateUsername(
                        username);

        registerValidationService
                .validateEmail(
                        email);

        Role role = registerValidationService
                .validateAndGetRole(
                        roleName);

        /*
         * ===========================================================================
         * CREATE USER ENTITY
         * ===========================================================================
         */

        User user = userFactory.createUser(
                username,
                email,
                request.getPassword(),
                role);

        /*
         * ===========================================================================
         * INSERT USER
         * ===========================================================================
         */

        userRepository.save(
                user);

        /*
         * ===========================================================================
         * CREATE EMAIL VERIFICATION TOKEN
         * ===========================================================================
         */

        EmailVerificationTokenResult tokenResult = emailVerificationTokenFactory
                .createToken(
                        user);

        /*
         * ===========================================================================
         * INSERT EMAIL VERIFICATION TOKEN
         * ===========================================================================
         */

        emailVerificationTokenRepository
                .save(
                        tokenResult
                                .getEmailVerificationToken());

        /*
         * ===========================================================================
         * GENERATE EMAIL VERIFICATION URL
         * ===========================================================================
         */

        String verificationUrl = frontendBaseUrl
                + verifyEmailPath
                + "?token="
                + tokenResult.getRawToken();

        /*
         * ===========================================================================
         * BUILD EMAIL REQUEST
         * ===========================================================================
         */

        SendEmailRequestDto sendEmailRequest = SendEmailRequestDto.builder()

                .toEmail(
                        user.getEmail())

                .subject(
                        "Verify your email")

                .body(
                        """
                                Welcome to CodeAxis.

                                Please verify your email by clicking below link:

                                %s

                                If you did not create this account,
                                please ignore this email.
                                """
                                .formatted(
                                        verificationUrl))

                .build();

        /*
         * ===========================================================================
         * SEND EMAIL
         * ===========================================================================
         */

        emailService.sendEmail(
                sendEmailRequest);

        /*
         * ===========================================================================
         * BUILD RESPONSE DTO
         * ===========================================================================
         */

        return registerResponseMapper
                .mapToResponse(
                        user);
    }
}

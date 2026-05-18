package codeaxis.api.service.auth;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import codeaxis.api.dto.auth.RegisterRequestDto;
import codeaxis.api.dto.auth.RegisterResponseDto;
import codeaxis.api.entity.Role;
import codeaxis.api.entity.User;
import codeaxis.api.repository.EmailVerificationTokenRepository;
import codeaxis.api.repository.UserRepository;
import codeaxis.api.service.auth.dto.EmailVerificationTokenResult;
import codeaxis.api.service.auth.factory.EmailVerificationTokenFactory;
import codeaxis.api.service.auth.factory.UserFactory;
import codeaxis.api.service.auth.mapper.RegisterResponseMapper;
import codeaxis.api.service.auth.validation.RegisterValidationService;
import codeaxis.api.service.mail.EmailService;
import codeaxis.api.service.mail.dto.SendEmailRequestDto;

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

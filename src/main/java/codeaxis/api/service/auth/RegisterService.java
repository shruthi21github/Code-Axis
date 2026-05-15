/*
===============================================================================
Service      : RegisterService

Description  :
    Orchestrates complete user registration workflow.

Responsibilities :
    - Normalize request input
    - Validate registration data
    - Create user entity
    - Persist user
    - Create email verification token
    - Persist verification token
    - Send verification email
    - Build registration response DTO

Tables Used  :
    - users
    - roles
    - email_verification_tokens

Transaction :
    Entire registration flow executes inside single database transaction.
===============================================================================
*/

package codeaxis.api.service.auth;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Value;

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

@Service
public class RegisterService {

    private final UserRepository userRepository;

    private final EmailVerificationTokenRepository emailVerificationTokenRepository;

    private final RegisterValidationService registerValidationService;

    private final UserFactory userFactory;

    private final EmailVerificationTokenFactory emailVerificationTokenFactory;

    private final RegisterResponseMapper registerResponseMapper;

    private final EmailService emailService;

    public RegisterService(
            UserRepository userRepository,

            EmailVerificationTokenRepository emailVerificationTokenRepository,

            RegisterValidationService registerValidationService,

            UserFactory userFactory,

            EmailVerificationTokenFactory emailVerificationTokenFactory,

            RegisterResponseMapper registerResponseMapper,

            EmailService emailService) {

        this.userRepository = userRepository;

        this.emailVerificationTokenRepository = emailVerificationTokenRepository;

        this.registerValidationService = registerValidationService;

        this.userFactory = userFactory;

        this.emailVerificationTokenFactory = emailVerificationTokenFactory;

        this.registerResponseMapper = registerResponseMapper;

        this.emailService = emailService;
    }

    /*
     * =============================================================================
     * ==
     * FRONTEND APPLICATION URL CONFIGURATION
     * =============================================================================
     * ==
     * 
     * Purpose :
     * Used to dynamically generate frontend email verification links.
     * 
     * Example Generated URL :
     * http://localhost:3000/verify-email?token=abc123
     * =============================================================================
     * ==
     */

    @Value("${app.frontend.base-url}")
    private String frontendBaseUrl;

    @Value("${app.frontend.verify-email-path}")
    private String verifyEmailPath;

    /*
     * =============================================================================
     * ==
     * REGISTER USER
     * =============================================================================
     * ==
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

        userRepository.save(user);

        /*
         * ===========================================================================
         * CREATE EMAIL VERIFICATION TOKEN
         * ===========================================================================
         */

        EmailVerificationTokenResult tokenResult = emailVerificationTokenFactory
                .createToken(user);

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
         * SEND EMAIL VERIFICATION MAIL
         * ===========================================================================
         */

        SendEmailRequestDto sendEmailRequest = new SendEmailRequestDto();

        sendEmailRequest.setToEmail(
                user.getEmail());

        sendEmailRequest.setSubject(
                "Verify your email");

        /*
         * =============================================================================
         * ==
         * GENERATE EMAIL VERIFICATION URL
         * =============================================================================
         * ==
         */

        String verificationUrl = frontendBaseUrl
                + verifyEmailPath
                + "?token="
                + tokenResult
                        .getRawToken();

        /*
         * =============================================================================
         * ==
         * BUILD EMAIL BODY
         * =============================================================================
         * ==
         */

        sendEmailRequest.setBody(
                """
                        Welcome to CodeAxis.

                        Please verify your email by clicking below link:

                        %s

                        If you did not create this account,
                        please ignore this email.
                        """
                        .formatted(
                                verificationUrl));

        emailService.sendEmail(
                sendEmailRequest);

        /*
         * ===========================================================================
         * BUILD RESPONSE DTO
         * ===========================================================================
         */

        return registerResponseMapper
                .mapToResponse(user);
    }
}

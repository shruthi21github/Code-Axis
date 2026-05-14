/*
===============================================================================
Service      : RegisterService

Description  :
    Orchestrates complete user registration workflow including:

    - Input normalization
    - Registration data validation
    - User entity creation
    - User persistence
    - Email verification token creation
    - Email verification token persistence
    - Registration response generation

Flow :
    1. Normalize request input
    2. Validate registration data
    3. Create user entity
    4. Persist user
    5. Create verification token
    6. Persist verification token
    7. Build response DTO

Tables Used  :
    - users
    - roles
    - email_verification_tokens

Components Used :
    - RegisterValidationService
    - UserFactory
    - EmailVerificationTokenFactory
    - RegisterResponseMapper

Security     :
    - Password stored using BCrypt hashing
    - Verification token stored as SHA-256 hash

Transaction  :
    Entire registration flow executes inside single database transaction.
===============================================================================
*/

package codeaxis.api.service.auth;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import codeaxis.api.dto.auth.RegisterRequestDto;
import codeaxis.api.dto.auth.RegisterResponseDto;
import codeaxis.api.entity.Role;
import codeaxis.api.entity.User;
import codeaxis.api.repository.EmailVerificationTokenRepository;
import codeaxis.api.repository.UserRepository;
import codeaxis.api.service.auth.factory.EmailVerificationTokenFactory;
import codeaxis.api.service.auth.factory.UserFactory;
import codeaxis.api.service.auth.mapper.RegisterResponseMapper;
import codeaxis.api.service.auth.validation.RegisterValidationService;

@Service
public class RegisterService
{
    /*
    ===========================================================================
    DEPENDENCIES
    ===========================================================================

    UserRepository :
        Handles users table persistence operations.

    EmailVerificationTokenRepository :
        Handles email_verification_tokens table persistence operations.

    RegisterValidationService :
        Handles registration business validations.

    UserFactory :
        Creates fully initialized User entity.

    EmailVerificationTokenFactory :
        Creates fully initialized EmailVerificationToken entity.

    RegisterResponseMapper :
        Maps User entity into RegisterResponseDto.
    */

    private final UserRepository userRepository;

    private final EmailVerificationTokenRepository
            emailVerificationTokenRepository;

    private final RegisterValidationService
            registerValidationService;

    private final UserFactory userFactory;

    private final EmailVerificationTokenFactory
            emailVerificationTokenFactory;

    private final RegisterResponseMapper
            registerResponseMapper;

    public RegisterService(
            UserRepository userRepository,

            EmailVerificationTokenRepository
                    emailVerificationTokenRepository,

            RegisterValidationService
                    registerValidationService,

            UserFactory userFactory,

            EmailVerificationTokenFactory
                    emailVerificationTokenFactory,

            RegisterResponseMapper registerResponseMapper)
    {
        this.userRepository = userRepository;

        this.emailVerificationTokenRepository =
                emailVerificationTokenRepository;

        this.registerValidationService =
                registerValidationService;

        this.userFactory = userFactory;

        this.emailVerificationTokenFactory =
                emailVerificationTokenFactory;

        this.registerResponseMapper =
                registerResponseMapper;
    }

    /*
    ===========================================================================
    REGISTER USER
    ===========================================================================

    Purpose :
        Registers new user account and creates associated
        email verification token.

    Workflow :
        1. Normalize request data
        2. Validate registration inputs
        3. Create user entity
        4. Persist user entity
        5. Create email verification token entity
        6. Persist email verification token
        7. Build registration response

    Transaction :
        Entire operation rolls back if any step fails.
    */

    @Transactional
    public RegisterResponseDto register(
            RegisterRequestDto request)
    {
        /*
        =======================================================================
        NORMALIZE INPUT
        =======================================================================

        Purpose :
            Ensures consistent storage and comparison behavior.

        Rules :
            - username -> lowercase
            - email -> lowercase
            - role name -> uppercase
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
        =======================================================================
        VALIDATE REGISTRATION DATA
        =======================================================================

        Validations :
            - Username uniqueness
            - Email uniqueness
            - Role existence
            - Role active status
            - Role deleted status

        Tables Used :
            - users
            - roles
        */

        registerValidationService
                .validateUsername(username);

        registerValidationService
                .validateEmail(email);

        Role role = registerValidationService
                .validateAndGetRole(roleName);

        /*
        =======================================================================
        CREATE USER ENTITY
        =======================================================================

        Purpose :
            Creates fully initialized User entity including:
                - UUID generation
                - BCrypt password hashing
                - Default account flags
                - Audit timestamps
        */

        User user = userFactory.createUser(
                username,
                email,
                request.getPassword(),
                role);

        /*
        =======================================================================
        INSERT USER
        =======================================================================

        Table :
            users

        Purpose :
            Persists newly registered user into database.
        */

        userRepository.save(user);

        /*
        =======================================================================
        CREATE EMAIL VERIFICATION TOKEN
        =======================================================================

        Purpose :
            Creates verification token associated with user.

        Security :
            - Raw token generated internally
            - SHA-256 hash stored in database
            - Token expiration managed centrally
        */

        /*
        =======================================================================
        INSERT EMAIL VERIFICATION TOKEN
        =======================================================================

        Table :
            email_verification_tokens

        Purpose :
            Persists generated verification token into database.
        */

        emailVerificationTokenRepository.save(
                emailVerificationTokenFactory
                        .createToken(user));

        /*
        =======================================================================
        BUILD RESPONSE DTO
        =======================================================================

        Purpose :
            Maps registered user entity into response object
            returned to controller/client.
        */

        return registerResponseMapper
                .mapToResponse(user);
    }
}

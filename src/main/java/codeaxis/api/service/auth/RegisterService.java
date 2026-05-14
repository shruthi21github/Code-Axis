/*
===============================================================================
Service      : RegisterService
Description  :
    Handles complete user registration workflow including:

    - Input normalization
    - Username uniqueness validation
    - Email uniqueness validation
    - Role validation
    - Password hashing
    - User creation
    - Email verification token creation
    - Registration response generation

Tables Used  :
    - users
    - roles
    - email_verification_tokens

Security     :
    - Password stored using BCrypt hashing
    - Verification token stored as SHA-256 hash

Transaction  :
    Entire registration flow executes inside single database transaction.
===============================================================================
*/

package codeaxis.api.service.auth;

import java.time.LocalDateTime;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.f4b6a3.uuid.UuidCreator;

import codeaxis.api.dto.auth.RegisterRequestDto;
import codeaxis.api.dto.auth.RegisterResponseDto;
import codeaxis.api.entity.EmailVerificationToken;
import codeaxis.api.entity.Role;
import codeaxis.api.entity.User;
import codeaxis.api.exception.ApiException;
import codeaxis.api.repository.EmailVerificationTokenRepository;
import codeaxis.api.repository.RoleRepository;
import codeaxis.api.repository.UserRepository;
import codeaxis.api.utils.Sha256Util;

@Service
public class RegisterService {
        private final UserRepository userRepository;

        private final RoleRepository roleRepository;

        private final EmailVerificationTokenRepository emailVerificationTokenRepository;

        private final BCryptPasswordEncoder passwordEncoder;

        public RegisterService(
                        UserRepository userRepository,

                        RoleRepository roleRepository,

                        EmailVerificationTokenRepository emailVerificationTokenRepository,

                        BCryptPasswordEncoder passwordEncoder) {
                this.userRepository = userRepository;

                this.roleRepository = roleRepository;

                this.emailVerificationTokenRepository = emailVerificationTokenRepository;

                this.passwordEncoder = passwordEncoder;
        }

        /*
         * ===========================================================================
         * REGISTER USER
         * ===========================================================================
         * 
         * Flow :
         * 1. Normalize request input
         * 2. Validate username uniqueness
         * 3. Validate email uniqueness
         * 4. Validate role
         * 5. Create user record
         * 6. Create email verification token
         * 7. Build response DTO
         * 
         * Transaction :
         * Entire operation rolls back if any step fails.
         */

        @Transactional
        public RegisterResponseDto register(
                        RegisterRequestDto request) {
                /*
                 * =======================================================================
                 * NORMALIZE INPUT
                 * =======================================================================
                 * 
                 * Purpose :
                 * Ensures consistent storage and comparison behavior.
                 * 
                 * Rules :
                 * - username -> lowercase
                 * - email -> lowercase
                 * - role name -> uppercase
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
                 * =======================================================================
                 * VALIDATE USERNAME UNIQUENESS
                 * =======================================================================
                 * 
                 * Table :
                 * users
                 * 
                 * Purpose :
                 * Prevents duplicate usernames.
                 */

                if (userRepository.existsByUsernameIgnoreCase(username)) {
                        throw new ApiException(
                                        HttpStatus.CONFLICT,
                                        "Username already exists");
                }

                /*
                 * =======================================================================
                 * VALIDATE EMAIL UNIQUENESS
                 * =======================================================================
                 * 
                 * Table :
                 * users
                 * 
                 * Purpose :
                 * Prevents duplicate email addresses.
                 */

                if (userRepository.existsByEmailIgnoreCase(email)) {
                        throw new ApiException(
                                        HttpStatus.CONFLICT,
                                        "Email address already exists");
                }

                /*
                 * =======================================================================
                 * FETCH ROLE
                 * =======================================================================
                 * 
                 * Table :
                 * roles
                 * 
                 * Purpose :
                 * Fetches requested role for validation and user assignment.
                 */

                Role role = roleRepository
                                .findByRoleNameIgnoreCase(roleName)
                                .orElse(null);

                /*
                 * =======================================================================
                 * VALIDATE ROLE EXISTS
                 * =======================================================================
                 * 
                 * Purpose :
                 * Ensures requested role exists.
                 */

                if (role == null) {
                        throw new ApiException(
                                        HttpStatus.NOT_FOUND,
                                        "User role not found");
                }

                /*
                 * =======================================================================
                 * VALIDATE ROLE ACTIVE
                 * =======================================================================
                 * 
                 * Purpose :
                 * Prevents registration using inactive role.
                 */

                if (Boolean.FALSE.equals(role.getIsActive())) {
                        throw new ApiException(
                                        HttpStatus.BAD_REQUEST,
                                        "User role inactive");
                }

                /*
                 * =======================================================================
                 * VALIDATE ROLE DELETED
                 * =======================================================================
                 * 
                 * Purpose :
                 * Prevents registration using deleted role.
                 */

                if (Boolean.TRUE.equals(role.getIsDeleted())) {
                        throw new ApiException(
                                        HttpStatus.BAD_REQUEST,
                                        "User role deleted");
                }

                /*
                 * =======================================================================
                 * GENERATE USER ID
                 * =======================================================================
                 * 
                 * Purpose :
                 * Generates time ordered UUID for optimized database indexing.
                 */

                UUID userId = UuidCreator.getTimeOrderedEpoch();

                /*
                 * =======================================================================
                 * HASH PASSWORD
                 * =======================================================================
                 * 
                 * Purpose :
                 * Converts plain password into secure BCrypt hash.
                 * 
                 * Security :
                 * Raw password is never stored in database.
                 */

                String passwordHash = passwordEncoder.encode(
                                request.getPassword());

                /*
                 * =======================================================================
                 * CREATE USER ENTITY
                 * =======================================================================
                 * 
                 * Table :
                 * users
                 * 
                 * Purpose :
                 * Builds new user entity before persistence.
                 */

                User user = new User();

                user.setUserId(userId);

                user.setRole(role);

                user.setUsername(username);

                user.setEmail(email);

                user.setPasswordHash(passwordHash);

                user.setIsEmailVerified(false);

                user.setIsLocked(false);

                user.setIsActive(true);

                user.setIsDeleted(false);

                user.setCreatedAt(LocalDateTime.now());

                user.setUpdatedAt(LocalDateTime.now());

                /*
                 * =======================================================================
                 * INSERT USER
                 * =======================================================================
                 * 
                 * Table :
                 * users
                 * 
                 * Purpose :
                 * Persists newly registered user into database.
                 */

                userRepository.save(user);

                /*
                 * =======================================================================
                 * GENERATE EMAIL VERIFICATION TOKEN
                 * =======================================================================
                 * 
                 * Purpose :
                 * Creates verification token for email verification workflow.
                 * 
                 * Security :
                 * Raw token is hashed before storing in database.
                 */

                String rawVerificationToken = UuidCreator
                                .getTimeOrderedEpoch()
                                .toString();

                String verificationTokenHash = Sha256Util.hash(
                                rawVerificationToken);

                /*
                 * =======================================================================
                 * CREATE EMAIL VERIFICATION TOKEN ENTITY
                 * =======================================================================
                 * 
                 * Table :
                 * email_verification_tokens
                 * 
                 * Purpose :
                 * Stores email verification token linked to registered user.
                 */

                EmailVerificationToken token = new EmailVerificationToken();

                token.setEmailVerificationTokenId(
                                UuidCreator.getTimeOrderedEpoch());

                token.setUser(user);

                token.setVerificationTokenHash(
                                verificationTokenHash);

                token.setExpiresAt(
                                LocalDateTime.now().plusHours(24));

                token.setIsActive(true);

                token.setCreatedAt(LocalDateTime.now());

                /*
                 * =======================================================================
                 * INSERT EMAIL VERIFICATION TOKEN
                 * =======================================================================
                 * 
                 * Table :
                 * email_verification_tokens
                 * 
                 * Purpose :
                 * Persists verification token into database.
                 */

                emailVerificationTokenRepository.save(token);

                /*
                 * =======================================================================
                 * BUILD REGISTER RESPONSE
                 * =======================================================================
                 * 
                 * Purpose :
                 * Creates final response DTO returned to controller/client.
                 */

                RegisterResponseDto response = new RegisterResponseDto();

                response.setUserId(
                                user.getUserId().toString());

                response.setRoleId(
                                role.getRoleId().toString());

                response.setUsername(
                                user.getUsername());

                response.setEmail(
                                user.getEmail());

                response.setRoleName(
                                role.getRoleName());

                response.setIsEmailVerified(
                                user.getIsEmailVerified());

                response.setIsActive(
                                user.getIsActive());

                response.setCreatedAt(
                                user.getCreatedAt());

                /*
                 * =======================================================================
                 * RETURN RESPONSE
                 * =======================================================================
                 * 
                 * Purpose :
                 * Returns enriched registration result back to caller.
                 */

                return response;
        }
}

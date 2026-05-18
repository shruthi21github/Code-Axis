package codeaxis.api.service.auth;

import java.time.LocalDateTime;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import codeaxis.api.dto.auth.LoginRequestDto;
import codeaxis.api.dto.auth.LoginResponseDto;
import codeaxis.api.entity.User;
import codeaxis.api.entity.UserSession;
import codeaxis.api.repository.UserRepository;
import codeaxis.api.repository.UserSessionRepository;
import codeaxis.api.security.JwtProvider;
import codeaxis.api.service.auth.factory.LoginResponseFactory;
import codeaxis.api.service.auth.factory.UserSessionFactory;
import codeaxis.api.service.auth.validation.LoginPasswordValidationService;
import codeaxis.api.service.auth.validation.LoginUserValidationService;
import codeaxis.api.service.auth.validation.LoginRequestValidationService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor

public class LoginService {

        private final UserRepository userRepository;

        private final UserSessionRepository userSessionRepository;

        private final LoginUserValidationService loginUserValidationService;

        private final LoginPasswordValidationService loginPasswordValidationService;

        private final UserSessionFactory userSessionFactory;

        private final LoginResponseFactory loginResponseFactory;

        private final JwtProvider jwtProvider;

        private final LoginRequestValidationService loginRequestValidationService;

        @Transactional
        public LoginResponseDto login(
                        LoginRequestDto requestDto) {

                /*
                 * =========================================================================
                 * VALIDATE REQUEST
                 * =========================================================================
                 */

                loginRequestValidationService
                                .validate(
                                                requestDto);

                /*
                 * =========================================================================
                 * FETCH USER
                 * =========================================================================
                 */

                User user = null;

                if (requestDto.getEmail() != null
                                && !requestDto.getEmail().isBlank()

                                &&

                                requestDto.getUsername() != null
                                && !requestDto.getUsername().isBlank()) {

                        user = userRepository
                                        .findByEmailIgnoreCaseAndUsernameIgnoreCase(
                                                        requestDto.getEmail(),
                                                        requestDto.getUsername())
                                        .orElse(null);
                }

                else if (requestDto.getEmail() != null
                                && !requestDto.getEmail().isBlank()) {

                        user = userRepository
                                        .findByEmailIgnoreCase(
                                                        requestDto.getEmail())
                                        .orElse(null);
                }

                else if (requestDto.getUsername() != null
                                && !requestDto.getUsername().isBlank()) {

                        user = userRepository
                                        .findByUsernameIgnoreCase(
                                                        requestDto.getUsername())
                                        .orElse(null);
                }

                /*
                 * =========================================================================
                 * VALIDATE USER
                 * =========================================================================
                 */

                loginUserValidationService
                                .validate(user);

                user = Objects.requireNonNull(user);

                /*
                 * =========================================================================
                 * VALIDATE PASSWORD
                 * =========================================================================
                 */

                loginPasswordValidationService
                                .validate(
                                                user,
                                                requestDto.getPassword());

                /*
                 * =========================================================================
                 * GENERATE TOKENS
                 * =========================================================================
                 */

                String accessToken = jwtProvider.generateAccessToken(
                                user);

                String refreshToken = jwtProvider.generateRefreshToken();

                String refreshTokenHash = jwtProvider.hashRefreshToken(
                                refreshToken);

                /*
                 * =========================================================================
                 * CREATE SESSION
                 * =========================================================================
                 */

                UserSession userSession = userSessionFactory.create(
                                user,
                                refreshTokenHash,
                                jwtProvider.getRefreshTokenExpiryDate());

                userSessionRepository.save(
                                userSession);

                /*
                 * =========================================================================
                 * UPDATE LAST LOGIN
                 * =========================================================================
                 */

                user.setLastLoginAt(
                                LocalDateTime.now());

                userRepository.save(
                                user);

                /*
                 * =========================================================================
                 * RESPONSE
                 * =========================================================================
                 */

                return loginResponseFactory.create(
                                accessToken,
                                refreshToken);
        }
}

package com.codeaxis.service.auth;

import java.time.LocalDateTime;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.codeaxis.dto.auth.LoginRequestDto;
import com.codeaxis.dto.auth.LoginResponseDto;
import com.codeaxis.entity.User;
import com.codeaxis.entity.UserSession;
import com.codeaxis.repository.UserRepository;
import com.codeaxis.repository.UserSessionRepository;
import com.codeaxis.security.JwtProvider;
import com.codeaxis.service.auth.factory.LoginResponseFactory;
import com.codeaxis.service.auth.factory.UserSessionFactory;
import com.codeaxis.service.auth.validation.LoginPasswordValidationService;
import com.codeaxis.service.auth.validation.LoginRequestValidationService;
import com.codeaxis.service.auth.validation.LoginUserValidationService;

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

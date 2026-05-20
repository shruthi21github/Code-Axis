package com.codeaxis.service.auth;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.codeaxis.dto.RefreshTokenResponse;
import com.codeaxis.entity.User;
import com.codeaxis.entity.UserSession;
import com.codeaxis.exception.ApiException;
import com.codeaxis.repository.UserSessionRepository;
import com.codeaxis.security.JwtProvider;
import com.github.f4b6a3.uuid.UuidCreator;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RefreshTokenService {

        @Value("${app.jwt.refresh-token-expiration-ms}")
        private Long refreshExpirationMs;

        private final UserSessionRepository userSessionRepository;
        private final JwtProvider jwtProvider;

        /*
         * CREATE SESSION (LOGIN)
         */
        @Transactional
        public UserSession createSession(User user, String refreshTokenHash) {

                userSessionRepository.revokeAllActiveSessionsByUser(
                                user,
                                LocalDateTime.now());

                UserSession session = new UserSession();

                session.setPkUserSessionId(
                                UuidCreator.getTimeOrderedEpoch());

                session.setFkUserId(user);

                session.setRefreshTokenHash(refreshTokenHash);

                session.setRefreshTokenExpiresAt(
                                LocalDateTime.now()
                                                .plusSeconds(refreshExpirationMs / 1000));

                session.setIsActive(true);

                session.setCreatedAt(LocalDateTime.now());

                session.setCreatedBy(user.getPkUserId());

                return userSessionRepository.save(session);
        }

        /*
         * REFRESH ACCESS TOKEN
         */
        @Transactional
        public RefreshTokenResponse refreshAccessToken(String refreshToken) {

                String refreshTokenHash = jwtProvider.hashRefreshToken(refreshToken);

                UserSession session = userSessionRepository
                                .findByRefreshTokenHashAndIsActiveTrue(refreshTokenHash)
                                .orElseThrow(() -> new ApiException(
                                                HttpStatus.UNAUTHORIZED,
                                                "Refresh token not found or already revoked"));

                if (session.getRevokedAt() != null) {
                        throw new ApiException(
                                        HttpStatus.UNAUTHORIZED,
                                        "Refresh token has been revoked. Please login again");
                }

                if (session.getRefreshTokenExpiresAt().isBefore(LocalDateTime.now())) {
                        session.setIsActive(false);
                        userSessionRepository.save(session);

                        throw new ApiException(
                                        HttpStatus.UNAUTHORIZED,
                                        "Refresh token has expired. Please login again");
                }

                User user = session.getFkUserId();

                String newAccessToken = jwtProvider.generateAccessToken(user);

                return new RefreshTokenResponse(newAccessToken);
        }

        /*
         * REVOKE SESSION (LOGOUT)
         */
        @Transactional
        public void revokeSession(String refreshToken) {

                String refreshTokenHash = jwtProvider.hashRefreshToken(refreshToken);

                UserSession session = userSessionRepository
                                .findByRefreshTokenHashAndIsActiveTrue(refreshTokenHash)
                                .orElseThrow(() -> new ApiException(
                                                HttpStatus.NOT_FOUND,
                                                "Session not found"));

                session.setIsActive(false);
                session.setRevokedAt(LocalDateTime.now());

                userSessionRepository.save(session);
        }
}

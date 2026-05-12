package com.codeaxis.service;

import com.codeaxis.entity.RefreshToken;
import com.codeaxis.entity.User;
import com.codeaxis.exception.TokenRefreshException;
import com.codeaxis.repository.RefreshTokenRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RefreshTokenService {

    @Value("${app.jwt.refresh-expiration-ms}")
    private Long refreshTokenDurationMs;

    private final RefreshTokenRepository refreshTokenRepository;

    public RefreshToken createRefreshToken(User user) {
        // Delete old token if exists
        refreshTokenRepository.findByUser(user)
                .ifPresent(refreshTokenRepository::delete);

        RefreshToken token = new RefreshToken();
        token.setUser(user);
        token.setToken(UUID.randomUUID().toString());
        token.setExpiryDate(Instant.now().plusMillis(refreshTokenDurationMs));
        token.setRevoked(false);

        return refreshTokenRepository.save(token);
    }

    public String refreshAccessToken(String requestToken) {
        RefreshToken token = refreshTokenRepository.findByToken(requestToken)
                .orElseThrow(() -> new TokenRefreshException(
                        "Refresh token not found"));

        if (token.isRevoked()) {
            throw new TokenRefreshException(
                    "Refresh token has been revoked. Please login again");
        }

        if (token.getExpiryDate().isBefore(Instant.now())) {
            refreshTokenRepository.delete(token);
            throw new TokenRefreshException(
                    "Refresh token has expired. Please login again");
        }

        return token.getUser().getEmail();
    }

    public void revokeToken(String requestToken) {
        RefreshToken token = refreshTokenRepository.findByToken(requestToken)
                .orElseThrow(() -> new TokenRefreshException(
                        "Refresh token not found"));

        token.setRevoked(true);
        refreshTokenRepository.save(token);
    }
}
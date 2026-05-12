package com.codeaxis.service;

import com.codeaxis.entity.RefreshToken;
import com.codeaxis.exception.TokenRefreshException;
import com.codeaxis.repository.RefreshTokenRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.Instant;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RefreshTokenService {

    private final RefreshTokenRepository
        refreshTokenRepository;

    public RefreshToken createRefreshToken() {
        RefreshToken token = new RefreshToken();
        token.setToken(
            UUID.randomUUID().toString());
        token.setExpiryDate(
            Instant.now().plusMillis(604800000));
        return refreshTokenRepository.save(token);
    }

    public String refreshAccessToken(
            String requestToken) {
        RefreshToken token = refreshTokenRepository
            .findByToken(requestToken)
            .orElseThrow(() ->
                new TokenRefreshException(
                    "Refresh token not found"));

        if (token.getExpiryDate()
                .isBefore(Instant.now())) {
            refreshTokenRepository.delete(token);
            throw new TokenRefreshException(
                "Refresh token expired");
        }

        return token.getToken();
    }
}
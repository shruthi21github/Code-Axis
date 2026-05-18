package codeaxis.api.security;

import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.time.Instant;
import java.util.Base64;
import java.util.Date;
import java.util.UUID;
import java.time.LocalDateTime;

import javax.crypto.SecretKey;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import codeaxis.api.entity.User;
import codeaxis.api.utils.Sha256Util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

@Service
public class JwtProvider {

        private static final SecureRandom SECURE_RANDOM = new SecureRandom();

        @Value("${app.jwt.secret-key}")
        private String secretKey;

        @Value("${app.jwt.access-token-expiration-ms}")
        private Long accessTokenExpirationMs;

        @Value("${app.jwt.refresh-token-expiration-ms}")
        private Long refreshTokenExpirationMs;

        /*
         * ===========================================================================
         * ACCESS TOKEN
         * ===========================================================================
         */

        public String generateAccessToken(
                        User user) {

                Instant now = Instant.now();

                Instant expiry = now.plusMillis(
                                accessTokenExpirationMs);

                return Jwts.builder()
                                .subject(
                                                user.getPkUserId().toString())
                                .claim(
                                                "email",
                                                user.getEmail())
                                .claim(
                                                "role",
                                                user.getFkRoleId().getRoleName())
                                .issuedAt(
                                                Date.from(now))
                                .expiration(
                                                Date.from(expiry))
                                .signWith(
                                                getSigningKey())
                                .compact();
        }

        /*
         * ===========================================================================
         * REFRESH TOKEN
         * ===========================================================================
         */

        public String generateRefreshToken() {

                byte[] randomBytes = new byte[64];

                SECURE_RANDOM.nextBytes(
                                randomBytes);

                return Base64.getUrlEncoder()
                                .withoutPadding()
                                .encodeToString(
                                                randomBytes);
        }

        public String hashRefreshToken(
                        String refreshToken) {

                return Sha256Util.hash(
                                refreshToken);
        }

        public LocalDateTime getRefreshTokenExpiryDate() {

                return LocalDateTime.now()
                                .plusSeconds(
                                                refreshTokenExpirationMs / 1000);
        }

        /*
         * ===========================================================================
         * TOKEN VALIDATION
         * ===========================================================================
         */

        public UUID extractUserId(
                        String accessToken) {

                Claims claims = extractClaims(
                                accessToken);

                return UUID.fromString(
                                claims.getSubject());
        }

        public boolean isAccessTokenValid(
                        String accessToken) {

                try {

                        extractClaims(
                                        accessToken);

                        return true;
                } catch (Exception ex) {

                        return false;
                }
        }

        /*
         * ===========================================================================
         * INTERNAL
         * ===========================================================================
         */

        private Claims extractClaims(
                        String accessToken) {

                return Jwts.parser()
                                .verifyWith(
                                                getSigningKey())
                                .build()
                                .parseSignedClaims(
                                                accessToken)
                                .getPayload();
        }

        private SecretKey getSigningKey() {

                return Keys.hmacShaKeyFor(
                                secretKey.getBytes(
                                                StandardCharsets.UTF_8));
        }
}
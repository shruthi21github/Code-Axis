package com.codeaxis.service; 
 
import com.codeaxis.entity.User; 
import com.codeaxis.entity.UserSession; 
import com.codeaxis.exception.TokenRefreshException; 
import com.codeaxis.repository.UserSessionRepository; 
import lombok.RequiredArgsConstructor; 
import org.springframework.beans.factory.annotation.Value; 
import org.springframework.stereotype.Service; 
import org.springframework.transaction.annotation.Transactional; 
import java.time.LocalDateTime; 
import java.util.UUID; 
 
@Service 
@RequiredArgsConstructor 
public class RefreshTokenService { 
 
    @Value("${app.jwt.refresh-expiration-ms}") 
    private Long refreshExpirationMs; 
 
    private final UserSessionRepository userSessionRepository; 
 
    // ── Called at LOGIN ────────────────────────────────────── 
    @Transactional 
    public UserSession createSession(User user) { 
        // Revoke all old sessions for this user 
        userSessionRepository.revokeAllActiveSessionsByUser( 
                user, LocalDateTime.now()); 
 
        // Create new session 
        UserSession session = new UserSession(); 
        session.setFkUser(user); 
        session.setRefreshTokenHash(UUID.randomUUID().toString()); 
        session.setRefreshTokenExpiresAt( 
                LocalDateTime.now().plusSeconds(refreshExpirationMs / 1000)); 
        session.setActive(true); 
 
        return userSessionRepository.save(session); 
    } 
 
    // ── Called at POST /api/auth/refresh-token ─────────────── 
    @Transactional 
    public String refreshAccessToken(String tokenHash) { 
        UserSession session = userSessionRepository 
                .findByRefreshTokenHashAndIsActiveTrue(tokenHash) 
                .orElseThrow(() -> new TokenRefreshException( 
                        "Refresh token not found or already revoked")); 
 
        // Check if revoked 
        if (session.getRevokedAt() != null) { 
            throw new TokenRefreshException( 
                    "Refresh token has been revoked. Please login again"); 
        } 
 
        // Check if expired 
        if (session.getRefreshTokenExpiresAt() 
                .isBefore(LocalDateTime.now())) { 
            session.setActive(false); 
            userSessionRepository.save(session); 
            throw new TokenRefreshException( 
                    "Refresh token has expired. Please login again"); 
        } 
 
        // Return email for JWT generation 
        return session.getFkUser().getEmail(); 
    } 
 
    // ── Called at LOGOUT ───────────────────────────────────── 
    @Transactional 
    public void revokeSession(String tokenHash) { 
        UserSession session = userSessionRepository 
                .findByRefreshTokenHashAndIsActiveTrue(tokenHash) 
                .orElseThrow(() -> new TokenRefreshException( 
                        "Session not found")); 
        session.setActive(false); 
        session.setRevokedAt(LocalDateTime.now()); 
        userSessionRepository.save(session); 
    } 
}
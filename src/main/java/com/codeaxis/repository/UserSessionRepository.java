package com.codeaxis.repository;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.codeaxis.entity.User;
import com.codeaxis.entity.UserSession;

public interface UserSessionRepository
        extends JpaRepository<UserSession, UUID> {

    /*
     * ===========================================================================
     * FIND ACTIVE SESSION BY TOKEN HASH
     * ===========================================================================
     */

    Optional<UserSession>
            findByRefreshTokenHashAndIsActiveTrue(
                    String refreshTokenHash);

    /*
     * ===========================================================================
     * FIND VALID NON-REVOKED ACTIVE SESSION
     * ===========================================================================
     */

    Optional<UserSession>
            findByRefreshTokenHashAndIsActiveTrueAndRevokedAtIsNullAndRefreshTokenExpiresAtAfter(
                    String refreshTokenHash,
                    LocalDateTime currentTime);

    /*
     * ===========================================================================
     * REVOKE ALL ACTIVE SESSIONS FOR USER
     * ===========================================================================
     */

    @Modifying
    @Query("""
            UPDATE UserSession s
               SET s.isActive = false,
                   s.revokedAt = :now
             WHERE s.fkUserId = :user
               AND s.isActive = true
            """)
    void revokeAllActiveSessionsByUser(
            @Param("user") User user,
            @Param("now") LocalDateTime now);

    /*
     * ===========================================================================
     * DELETE SESSIONS BY USER
     * ===========================================================================
     */

    void deleteByFkUserId(
            User fkUserId);
}

package com.codeaxis.repository; 
 
import com.codeaxis.entity.User; 
import com.codeaxis.entity.UserSession; 
import org.springframework.data.jpa.repository.JpaRepository; 
import org.springframework.data.jpa.repository.Modifying; 
import org.springframework.data.jpa.repository.Query; 
import org.springframework.data.repository.query.Param; 
import java.time.LocalDateTime; 
import java.util.Optional; 
import java.util.UUID; 
 
public interface UserSessionRepository extends JpaRepository<UserSession, UUID> { 
 
    // Find active session by token hash 
    Optional<UserSession> findByRefreshTokenHashAndIsActiveTrue( 
            String refreshTokenHash); 
 
    // Revoke all active sessions for a user (used on login and logout) 
    @Modifying 
    @Query("UPDATE UserSession s SET s.isActive = false," + 
           " s.revokedAt = :now WHERE s.fkUser = :user AND s.isActive = true") 
    void revokeAllActiveSessionsByUser( 
            @Param("user") User user, 
            @Param("now") LocalDateTime now); 
} 
package codeaxis.api.repository;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import codeaxis.api.entity.User;
import codeaxis.api.entity.UserSession;

public interface UserSessionRepository extends JpaRepository<UserSession, UUID> {

    Optional<UserSession> findByRefreshTokenHashAndIsActiveTrueAndRevokedAtIsNullAndRefreshTokenExpiresAtAfter(
            String refreshTokenHash,
            LocalDateTime currentTime);

    void deleteByFkUserId(User fkUserId);
}

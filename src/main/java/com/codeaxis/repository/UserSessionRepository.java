package com.codeaxis.repository;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.codeaxis.entity.User;
import com.codeaxis.entity.UserSession;

public interface UserSessionRepository extends JpaRepository<UserSession, UUID> {

    Optional<UserSession> findByRefreshTokenHashAndIsActiveTrueAndRevokedAtIsNullAndRefreshTokenExpiresAtAfter(
            String refreshTokenHash,
            LocalDateTime currentTime);

    void deleteByFkUserId(User fkUserId);
}

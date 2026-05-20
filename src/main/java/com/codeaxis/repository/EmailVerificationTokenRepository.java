package com.codeaxis.repository;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.codeaxis.entity.EmailVerificationToken;

public interface EmailVerificationTokenRepository
                extends JpaRepository<EmailVerificationToken, UUID> {

        Optional<EmailVerificationToken> findByVerificationTokenHashAndIsActiveTrueAndExpiresAtAfter(
                        String verificationTokenHash,
                        LocalDateTime currentTime);
}

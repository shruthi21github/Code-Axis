package codeaxis.api.repository;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import codeaxis.api.entity.EmailVerificationToken;

public interface EmailVerificationTokenRepository
                extends JpaRepository<EmailVerificationToken, UUID> {

        Optional<EmailVerificationToken> findByVerificationTokenHashAndIsActiveTrueAndExpiresAtAfter(
                        String verificationTokenHash,
                        LocalDateTime currentTime);
}

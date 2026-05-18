package com.codeaxis.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "user_sessions")
@Data
public class UserSession {

    @Id
    @Column(name = "pk_user_session_id",
            columnDefinition = "binary(16)",
            updatable = false,
            nullable = false)
    private UUID pkUserSessionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "fk_user_id",
               columnDefinition = "binary(16)",
               nullable = false)
    private User fkUser;

    @Column(name = "refresh_token_hash", nullable = false)
    private String refreshTokenHash;

    @Column(name = "refresh_token_expires_at", nullable = false)
    private LocalDateTime refreshTokenExpiresAt;

    @Column(name = "revoked_at")
    private LocalDateTime revokedAt;

    @Column(name = "is_active", nullable = false)
    private boolean isActive = true;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "created_by",
            columnDefinition = "binary(16)")
    private UUID createdBy;

    @PrePersist
    protected void onCreate() {
        if (this.pkUserSessionId == null)
            this.pkUserSessionId = UUID.randomUUID();
        this.createdAt = LocalDateTime.now();
    }
}
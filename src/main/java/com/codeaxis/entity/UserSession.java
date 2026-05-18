package com.codeaxis.entity;

import java.time.LocalDateTime;
import java.util.UUID;

import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "user_sessions")

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class UserSession {

    /*
     * ===========================================================================
     * PRIMARY KEY
     * ===========================================================================
     */

    @Id
    @JdbcTypeCode(SqlTypes.BINARY)
    @Column(name = "pk_user_session_id", columnDefinition = "BINARY(16)", nullable = false)
    private UUID pkUserSessionId;

    /*
     * ===========================================================================
     * RELATIONSHIPS
     * ===========================================================================
     */

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "fk_user_id", nullable = false, columnDefinition = "BINARY(16)")
    private User fkUserId;

    /*
     * ===========================================================================
     * REFRESH TOKEN
     * ===========================================================================
     */

    @Column(name = "refresh_token_hash", nullable = false, length = 255)
    private String refreshTokenHash;

    @Column(name = "refresh_token_expires_at", nullable = false)
    private LocalDateTime refreshTokenExpiresAt;

    /*
     * ===========================================================================
     * STATUS
     * ===========================================================================
     */

    @Column(name = "revoked_at")
    private LocalDateTime revokedAt;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive;

    /*
     * ===========================================================================
     * AUDIT
     * ===========================================================================
     */

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @JdbcTypeCode(SqlTypes.BINARY)
    @Column(name = "created_by", columnDefinition = "BINARY(16)")
    private UUID createdBy;
}

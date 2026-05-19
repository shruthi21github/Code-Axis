package com.codeaxis.entity;

import java.time.LocalDateTime;
import java.util.UUID;

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

import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

@Entity
@Table(name = "email_verification_tokens")

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class EmailVerificationToken {

    /*
     * ===========================================================================
     * PRIMARY KEY
     * ===========================================================================
     */

    @Id
    @JdbcTypeCode(SqlTypes.BINARY)
    @Column(name = "pk_email_verification_token_id", columnDefinition = "BINARY(16)", nullable = false)
    private UUID pkEmailVerificationTokenId;

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
     * TOKEN
     * ===========================================================================
     */

    @Column(name = "verification_token_hash", nullable = false, length = 255)
    private String verificationTokenHash;

    /*
     * ===========================================================================
     * STATUS
     * ===========================================================================
     */

    @Column(name = "expires_at", nullable = false)
    private LocalDateTime expiresAt;

    @Column(name = "verified_at")
    private LocalDateTime verifiedAt;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive;

    /*
     * ===========================================================================
     * AUDIT
     * ===========================================================================
     */

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;
}

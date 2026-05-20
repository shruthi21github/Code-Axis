package com.codeaxis.entity;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "users")

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class User {

    /*
     * ===========================================================================
     * PRIMARY KEY
     * ===========================================================================
     */

    @Id
    @org.hibernate.annotations.JdbcTypeCode(org.hibernate.type.SqlTypes.BINARY)
    @Column(name = "pk_user_id", columnDefinition = "BINARY(16)", nullable = false)
    private UUID pkUserId;

    /*
     * ===========================================================================
     * RELATIONSHIPS
     * ===========================================================================
     */

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "fk_role_id", nullable = false, columnDefinition = "BINARY(16)")
    private Role fkRoleId;

    /*
     * ===========================================================================
     * USER DETAILS
     * ===========================================================================
     */

    @Column(name = "username", nullable = false, unique = true, length = 100)
    private String username;

    @Column(name = "email", nullable = false, unique = true, length = 255)
    private String email;

    @Column(name = "phone_number", length = 20)
    private String phoneNumber;

    /*
     * ===========================================================================
     * AUTH
     * ===========================================================================
     */

    @Column(name = "password_hash", nullable = false, length = 255)
    private String passwordHash;

    @Column(name = "is_email_verified", nullable = false)
    private Boolean isEmailVerified;

    @Column(name = "email_verified_at")
    private LocalDateTime emailVerifiedAt;

    /*
     * ===========================================================================
     * LOCKING
     * ===========================================================================
     */

    @Column(name = "is_locked", nullable = false)
    private Boolean isLocked;

    @Column(name = "locked_at")
    private LocalDateTime lockedAt;

    /*
     * ===========================================================================
     * LOGIN
     * ===========================================================================
     */

    @Column(name = "last_login_at")
    private LocalDateTime lastLoginAt;

    /*
     * ===========================================================================
     * STATUS
     * ===========================================================================
     */

    @Column(name = "is_active", nullable = false)
    private Boolean isActive;

    /*
     * ===========================================================================
     * SOFT DELETE
     * ===========================================================================
     */

    @Column(name = "is_deleted", nullable = false)
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;

    /*
     * ===========================================================================
     * AUDIT
     * ===========================================================================
     */

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by")
    private User createdBy;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "updated_by")
    private User updatedBy;

    /*
     * ===========================================================================
     * REVERSE RELATIONSHIPS
     * ===========================================================================
     */

    @JsonIgnore
    @OneToMany(mappedBy = "createdBy", fetch = FetchType.LAZY)
    private List<User> createdUsers;

    @JsonIgnore
    @OneToMany(mappedBy = "updatedBy", fetch = FetchType.LAZY)
    private List<User> updatedUsers;
}

package com.codeaxis.rolebasedaccess.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "users")

@AttributeOverride(
        name = "id",
        column = @Column(
                name = "pk_user_id",
                columnDefinition = "BINARY(16)"
        )
)
public class User extends BaseEntity {

    @ManyToOne(fetch = FetchType.EAGER)

    @JoinColumn(
            name = "fk_role_id",
            nullable = false
    )
    private Role role;

    @Column(name = "username", nullable = false, unique = true)
    private String username;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @Column(name = "is_locked")
    private Boolean isLocked;

    @Column(name = "locked_at")
    private LocalDateTime lockedAt;

    @Column(name = "last_login_at")
    private LocalDateTime lastLoginAt;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "is_deleted")
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;

    @Column(name = "is_email_verified")
    private Boolean isEmailVerified;

    @Column(name = "email_verified_at")
    private LocalDateTime emailVerifiedAt;

    // ROLE

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    // USERNAME

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // EMAIL

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // PHONE NUMBER

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    // PASSWORD HASH

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    // IS LOCKED

    public Boolean getIsLocked() {
        return isLocked;
    }

    public void setIsLocked(Boolean locked) {
        isLocked = locked;
    }

    // LOCKED AT

    public LocalDateTime getLockedAt() {
        return lockedAt;
    }

    public void setLockedAt(LocalDateTime lockedAt) {
        this.lockedAt = lockedAt;
    }

    // LAST LOGIN AT

    public LocalDateTime getLastLoginAt() {
        return lastLoginAt;
    }

    public void setLastLoginAt(LocalDateTime lastLoginAt) {
        this.lastLoginAt = lastLoginAt;
    }

    // IS ACTIVE

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean active) {
        isActive = active;
    }

    // IS DELETED

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean deleted) {
        isDeleted = deleted;
    }

    // DELETED AT

    public LocalDateTime getDeletedAt() {
        return deletedAt;
    }

    public void setDeletedAt(LocalDateTime deletedAt) {
        this.deletedAt = deletedAt;
    }

    // EMAIL VERIFIED

    public Boolean getIsEmailVerified() {
        return isEmailVerified;
    }

    public void setIsEmailVerified(Boolean emailVerified) {
        isEmailVerified = emailVerified;
    }

    // EMAIL VERIFIED AT

    public LocalDateTime getEmailVerifiedAt() {
        return emailVerifiedAt;
    }

    public void setEmailVerifiedAt(LocalDateTime emailVerifiedAt) {
        this.emailVerifiedAt = emailVerifiedAt;
    }
}
package com.codeaxis.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;

import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.LocalDateTime;
import java.util.UUID;

@MappedSuperclass
public abstract class BaseEntity {

    @Id

    @JdbcTypeCode(SqlTypes.BINARY)

    @Column(
            nullable = false,
            updatable = false,
            columnDefinition = "BINARY(16)"
    )
    protected UUID id;

    @Column(name = "created_at", updatable = false)
    protected LocalDateTime createdAt;

    @Column(name = "updated_at")
    protected LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {

        if (this.id == null) {
            this.id = UUID.randomUUID();
        }

        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {

        this.updatedAt = LocalDateTime.now();
    }

    // ID

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    // CREATED AT

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    // UPDATED AT

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
}
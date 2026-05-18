package com.codeaxis.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "designations")
@Data
public class Designation {

    @Id
    @Column(name = "pk_designation_id",
            columnDefinition = "binary(16)",
            updatable = false,
            nullable = false)
    private UUID pkDesignationId;

    @Column(name = "designation_name",
            nullable = false, unique = true)
    private String designationName;

    @Column(name = "designation_description")
    private String designationDescription;

    @Column(name = "is_active", nullable = false)
    private boolean isActive = true;

    @Column(name = "is_deleted", nullable = false)
    private boolean isDeleted = false;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        if (this.pkDesignationId == null)
            this.pkDesignationId = UUID.randomUUID();
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
}
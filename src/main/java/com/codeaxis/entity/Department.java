package com.codeaxis.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "departments")
@Data
public class Department {

    @Id
    @Column(name = "pk_department_id",
            columnDefinition = "binary(16)",
            updatable = false,
            nullable = false)
    private UUID pkDepartmentId;

    @Column(name = "department_name",
            nullable = false, unique = true)
    private String departmentName;

    @Column(name = "department_description")
    private String departmentDescription;

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
        if (this.pkDepartmentId == null)
            this.pkDepartmentId = UUID.randomUUID();
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
}
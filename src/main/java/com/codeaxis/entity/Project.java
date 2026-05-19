package com.codeaxis.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "projects")
@Data
public class Project {

    @Id
    @Column(name = "pk_project_id",
            columnDefinition = "binary(16)",
            updatable = false,
            nullable = false)
    private UUID pkProjectId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "fk_project_status_id",
               columnDefinition = "binary(16)",
               nullable = false)
    private ProjectStatus fkProjectStatus;

    @Column(name = "project_code", nullable = false, unique = true)
    private String projectCode;

    @Column(name = "project_name", nullable = false)
    private String projectName;

    @Column(name = "project_description",
            columnDefinition = "TEXT")
    private String projectDescription;

    @Column(name = "start_at")
    private LocalDateTime startAt;

    @Column(name = "deadline_at")
    private LocalDateTime deadlineAt;

    @Column(name = "is_active", nullable = false)
    private boolean isActive = true;

    @Column(name = "is_deleted", nullable = false)
    private boolean isDeleted = false;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "created_by",
            columnDefinition = "binary(16)")
    private UUID createdBy;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @Column(name = "updated_by",
            columnDefinition = "binary(16)")
    private UUID updatedBy;

    @PrePersist
    protected void onCreate() {
        if (this.pkProjectId == null)
            this.pkProjectId = UUID.randomUUID();
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
}
package com.codeaxis.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "task_statuses")
@Data
public class TaskStatus {

    @Id
    @Column(name = "pk_task_status_id",
            columnDefinition = "binary(16)",
            updatable = false,
            nullable = false)
    private UUID pkTaskStatusId;

    @Column(name = "status_name",
            nullable = false, unique = true)
    private String statusName;

    @Column(name = "status_description")
    private String statusDescription;

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
        if (this.pkTaskStatusId == null)
            this.pkTaskStatusId = UUID.randomUUID();
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
}
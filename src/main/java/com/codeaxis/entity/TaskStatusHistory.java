package com.codeaxis.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "task_status_history")
@Data
public class TaskStatusHistory {

    @Id
    @Column(name = "pk_task_status_history_id",
            columnDefinition = "binary(16)",
            updatable = false,
            nullable = false)
    private UUID pkTaskStatusHistoryId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "fk_task_id",
               columnDefinition = "binary(16)",
               nullable = false)
    private Task fkTask;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "fk_task_status_id",
               columnDefinition = "binary(16)",
               nullable = false)
    private TaskStatus fkTaskStatus;

    @Column(name = "changed_at", nullable = false)
    private LocalDateTime changedAt;

    @Column(name = "changed_by",
            columnDefinition = "binary(16)")
    private UUID changedBy;

    @Column(name = "remarks")
    private String remarks;

    @PrePersist
    protected void onCreate() {
        if (this.pkTaskStatusHistoryId == null)
            this.pkTaskStatusHistoryId = UUID.randomUUID();
        if (this.changedAt == null)
            this.changedAt = LocalDateTime.now();
    }
}
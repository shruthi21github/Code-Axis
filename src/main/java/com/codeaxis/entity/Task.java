package com.codeaxis.entity;

import java.math.BigDecimal;
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
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tasks")

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Task {

    /*
     * ===========================================================================
     * PRIMARY KEY
     * ===========================================================================
     */

    @Id
    @JdbcTypeCode(SqlTypes.BINARY)

    @Column(
            name = "pk_task_id",
            columnDefinition = "BINARY(16)",
            nullable = false
    )
    private UUID pkTaskId;

    /*
     * ===========================================================================
     * RELATIONSHIPS
     * ===========================================================================
     */

    @ManyToOne(fetch = FetchType.EAGER)

    @JoinColumn(
            name = "fk_project_id",
            nullable = false,
            columnDefinition = "BINARY(16)"
    )
    private Project fkProjectId;

    @ManyToOne(fetch = FetchType.EAGER)

    @JoinColumn(
            name = "fk_user_id",
            nullable = false,
            columnDefinition = "BINARY(16)"
    )
    private User fkUserId;

    @ManyToOne(fetch = FetchType.EAGER)

    @JoinColumn(
            name = "fk_task_status_id",
            nullable = false,
            columnDefinition = "BINARY(16)"
    )
    private TaskStatus fkTaskStatusId;

    @ManyToOne(fetch = FetchType.EAGER)

    @JoinColumn(
            name = "fk_task_priority_id",
            nullable = false,
            columnDefinition = "BINARY(16)"
    )
    private TaskPriority fkTaskPriorityId;

    /*
     * ===========================================================================
     * TASK DETAILS
     * ===========================================================================
     */

    @Column(
            name = "task_title",
            nullable = false,
            length = 255
    )
    private String taskTitle;

    @Column(
            name = "task_description",
            columnDefinition = "TEXT"
    )
    private String taskDescription;

    /*
     * ===========================================================================
     * TIME TRACKING
     * ===========================================================================
     */

    @Column(
            name = "estimated_hours",
            precision = 10,
            scale = 2
    )
    private BigDecimal estimatedHours;

    @Column(
            name = "actual_hours",
            precision = 10,
            scale = 2
    )
    private BigDecimal actualHours;

    /*
     * ===========================================================================
     * TASK TIMELINE
     * ===========================================================================
     */

    @Column(name = "start_at")
    private LocalDateTime startAt;

    @Column(name = "deadline_at")
    private LocalDateTime deadlineAt;

    @Column(name = "completed_at")
    private LocalDateTime completedAt;

    /*
     * ===========================================================================
     * STATUS
     * ===========================================================================
     */

    @Column(
            name = "is_active",
            nullable = false
    )
    private Boolean isActive;

    /*
     * ===========================================================================
     * SOFT DELETE
     * ===========================================================================
     */

    @Column(
            name = "is_deleted",
            nullable = false
    )
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;

    /*
     * ===========================================================================
     * AUDIT
     * ===========================================================================
     */

    @Column(
            name = "created_at",
            nullable = false
    )
    private LocalDateTime createdAt;

    @ManyToOne(fetch = FetchType.LAZY)

    @JoinColumn(
            name = "created_by",
            columnDefinition = "BINARY(16)"
    )
    private User createdBy;

    @Column(
            name = "updated_at",
            nullable = false
    )
    private LocalDateTime updatedAt;

    @ManyToOne(fetch = FetchType.LAZY)

    @JoinColumn(
            name = "updated_by",
            columnDefinition = "BINARY(16)"
    )
    private User updatedBy;

    /*
     * ===========================================================================
     * AUTO UUID + TIMESTAMP
     * ===========================================================================
     */

    @PrePersist
    public void prePersist() {

        if (this.pkTaskId == null) {

            this.pkTaskId = UUID.randomUUID();
        }

        this.createdAt = LocalDateTime.now();

        this.updatedAt = LocalDateTime.now();

        if (this.isActive == null) {

            this.isActive = true;
        }

        if (this.isDeleted == null) {

            this.isDeleted = false;
        }
    }
}
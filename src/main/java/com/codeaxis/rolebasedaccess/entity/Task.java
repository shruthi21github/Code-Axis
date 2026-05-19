package com.codeaxis.rolebasedaccess.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "tasks")

@AttributeOverride(
        name = "id",
        column = @Column(
                name = "pk_task_id",
                columnDefinition = "BINARY(16)"
        )
)
public class Task extends BaseEntity {

    @Column(name = "fk_project_id")
    private UUID projectId;

    @Column(name = "fk_user_id")
    private UUID userId;

    @Column(name = "fk_task_status_id")
    private UUID taskStatusId;

    @Column(name = "fk_task_priority_id")
    private UUID taskPriorityId;

    @Column(name = "task_title")
    private String taskTitle;

    @Column(name = "task_description")
    private String taskDescription;

    @Column(name = "estimated_hours")
    private BigDecimal estimatedHours;

    @Column(name = "actual_hours")
    private BigDecimal actualHours;

    @Column(name = "start_at")
    private LocalDateTime startAt;

    @Column(name = "deadline_at")
    private LocalDateTime deadlineAt;

    @Column(name = "completed_at")
    private LocalDateTime completedAt;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "is_deleted")
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;

    // PROJECT ID

    public UUID getProjectId() {
        return projectId;
    }

    public void setProjectId(UUID projectId) {
        this.projectId = projectId;
    }

    // USER ID

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    // TASK STATUS ID

    public UUID getTaskStatusId() {
        return taskStatusId;
    }

    public void setTaskStatusId(UUID taskStatusId) {
        this.taskStatusId = taskStatusId;
    }

    // TASK PRIORITY ID

    public UUID getTaskPriorityId() {
        return taskPriorityId;
    }

    public void setTaskPriorityId(UUID taskPriorityId) {
        this.taskPriorityId = taskPriorityId;
    }

    // TASK TITLE

    public String getTaskTitle() {
        return taskTitle;
    }

    public void setTaskTitle(String taskTitle) {
        this.taskTitle = taskTitle;
    }

    // TASK DESCRIPTION

    public String getTaskDescription() {
        return taskDescription;
    }

    public void setTaskDescription(String taskDescription) {
        this.taskDescription = taskDescription;
    }

    // ESTIMATED HOURS

    public BigDecimal getEstimatedHours() {
        return estimatedHours;
    }

    public void setEstimatedHours(
            BigDecimal estimatedHours) {

        this.estimatedHours = estimatedHours;
    }

    // ACTUAL HOURS

    public BigDecimal getActualHours() {
        return actualHours;
    }

    public void setActualHours(
            BigDecimal actualHours) {

        this.actualHours = actualHours;
    }

    // START AT

    public LocalDateTime getStartAt() {
        return startAt;
    }

    public void setStartAt(
            LocalDateTime startAt) {

        this.startAt = startAt;
    }

    // DEADLINE AT

    public LocalDateTime getDeadlineAt() {
        return deadlineAt;
    }

    public void setDeadlineAt(
            LocalDateTime deadlineAt) {

        this.deadlineAt = deadlineAt;
    }

    // COMPLETED AT

    public LocalDateTime getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(
            LocalDateTime completedAt) {

        this.completedAt = completedAt;
    }

    // IS ACTIVE

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(
            Boolean active) {

        isActive = active;
    }

    // IS DELETED

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(
            Boolean deleted) {

        isDeleted = deleted;
    }

    // DELETED AT

    public LocalDateTime getDeletedAt() {
        return deletedAt;
    }

    public void setDeletedAt(
            LocalDateTime deletedAt) {

        this.deletedAt = deletedAt;
    }
}
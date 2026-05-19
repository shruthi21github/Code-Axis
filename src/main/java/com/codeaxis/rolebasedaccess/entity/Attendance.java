package com.codeaxis.rolebasedaccess.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "attendance_events")

@AttributeOverride(
        name = "id",
        column = @Column(
                name = "pk_attendance_event_id",
                columnDefinition = "BINARY(16)"
        )
)
public class Attendance extends BaseEntity {

    @Column(name = "fk_user_id")
    private UUID userId;

    @Column(name = "fk_attendance_event_type_id")
    private UUID attendanceEventTypeId;

    @Column(name = "event_at")
    private LocalDateTime eventAt;

    @Column(name = "notes")
    private String notes;

    // USER ID

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    // ATTENDANCE EVENT TYPE ID

    public UUID getAttendanceEventTypeId() {
        return attendanceEventTypeId;
    }

    public void setAttendanceEventTypeId(
            UUID attendanceEventTypeId) {

        this.attendanceEventTypeId =
                attendanceEventTypeId;
    }

    // EVENT AT

    public LocalDateTime getEventAt() {
        return eventAt;
    }

    public void setEventAt(LocalDateTime eventAt) {
        this.eventAt = eventAt;
    }

    // NOTES

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
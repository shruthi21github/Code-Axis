/*
===============================================================================
Table       : attendance_events
Description :
    Stores attendance activity for both employees and students
    through users table.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS attendance_events
(
    pk_attendance_event_id         BINARY(16)                    NOT NULL,

    fk_user_id                     BINARY(16)                    NOT NULL,

    fk_attendance_event_type_id    BINARY(16)                    NOT NULL,

    event_at                       TIMESTAMP                     NOT NULL,

    notes                          VARCHAR(500)                  NULL,

    created_at                     TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                     BINARY(16)                    NULL,

    CONSTRAINT pk_attendance_events
        PRIMARY KEY (pk_attendance_event_id),

    CONSTRAINT fk_attendance_events_user_id
        FOREIGN KEY (fk_user_id)
        REFERENCES users(pk_user_id),

    CONSTRAINT fk_attendance_events_event_type_id
        FOREIGN KEY (fk_attendance_event_type_id)
        REFERENCES attendance_event_types(pk_attendance_event_type_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE attendance_events;

-- ============================================================================
-- Show table DDL
-- ============================================================================

SHOW CREATE TABLE attendance_events;
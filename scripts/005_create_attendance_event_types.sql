/*
===============================================================================
Table       : attendance_event_types
Description :
    Master table for attendance event types.

Examples:
    - CHECK_IN
    - CHECK_OUT
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS attendance_event_types
(
    pk_attendance_event_type_id   BINARY(16)                 NOT NULL,
    event_type_name               VARCHAR(100)               NOT NULL,
    event_type_description        VARCHAR(255)               NULL,

    is_active                     BOOLEAN                    NOT NULL DEFAULT TRUE,

    is_deleted                    BOOLEAN                    NOT NULL DEFAULT FALSE,
    deleted_at                    TIMESTAMP                  NULL,

    created_at                    TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                    BINARY(16)                 NULL,

    updated_at                    TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                              ON UPDATE CURRENT_TIMESTAMP,
    updated_by                    BINARY(16)                 NULL,

    CONSTRAINT pk_attendance_event_types
        PRIMARY KEY (pk_attendance_event_type_id),

    CONSTRAINT uq_attendance_event_types_event_type_name
        UNIQUE (event_type_name)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE attendance_event_types;

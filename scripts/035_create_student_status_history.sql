/*
===============================================================================
Table       : student_status_history
Description :
    Tracks historical student status changes.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS student_status_history
(
    pk_student_status_history_id     BINARY(16)                    NOT NULL,

    fk_student_id                    BINARY(16)                    NOT NULL,
    fk_student_status_id             BINARY(16)                    NOT NULL,

    changed_at                       TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    changed_by                       BINARY(16)                    NULL,

    remarks                          VARCHAR(500)                  NULL,

    CONSTRAINT pk_student_status_history
        PRIMARY KEY (pk_student_status_history_id),

    CONSTRAINT fk_student_status_history_student_id
        FOREIGN KEY (fk_student_id)
        REFERENCES students(pk_student_id),

    CONSTRAINT fk_student_status_history_student_status_id
        FOREIGN KEY (fk_student_status_id)
        REFERENCES student_statuses(pk_student_status_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE student_status_history;

-- ============================================================================
-- Show table DDL
-- ============================================================================

SHOW CREATE TABLE student_status_history;

/*
===============================================================================
Table       : student_statuses
Description :
    Lookup table for normalized student statuses.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS student_statuses
(
    pk_student_status_id     BINARY(16)                    NOT NULL,

    status_name              VARCHAR(100)                  NOT NULL,
    status_description       VARCHAR(255)                  NULL,

    is_active                BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted               BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at               TIMESTAMP                     NULL,

    created_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by               BINARY(16)                    NULL,

    updated_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                            ON UPDATE CURRENT_TIMESTAMP,
    updated_by               BINARY(16)                    NULL,

    CONSTRAINT pk_student_statuses
        PRIMARY KEY (pk_student_status_id),

    CONSTRAINT uq_student_statuses_status_name
        UNIQUE (status_name)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE student_statuses;

-- ============================================================================
-- Show table DDL
-- ============================================================================

SHOW CREATE TABLE student_statuses;
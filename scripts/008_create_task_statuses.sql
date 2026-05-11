/*
===============================================================================
Table       : task_statuses
Description :
    Master table for task statuses.

Examples:
    - pending
    - in_progress
    - completed
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS task_statuses
(
    pk_task_status_id        BINARY(16)                    NOT NULL,
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

    CONSTRAINT pk_task_statuses
        PRIMARY KEY (pk_task_status_id),

    CONSTRAINT uq_task_statuses_status_name
        UNIQUE (status_name)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE task_statuses;

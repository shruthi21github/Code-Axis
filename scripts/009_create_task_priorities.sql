/*
===============================================================================
Table       : task_priorities
Description :
    Master table for task priority levels.

Examples:
    - low
    - medium
    - high
    - critical
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS task_priorities
(
    pk_task_priority_id      BINARY(16)                    NOT NULL,
    priority_name            VARCHAR(100)                  NOT NULL,
    priority_description     VARCHAR(255)                  NULL,

    is_active                BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted               BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at               TIMESTAMP                     NULL,

    created_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by               BINARY(16)                    NULL,

    updated_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                            ON UPDATE CURRENT_TIMESTAMP,
    updated_by               BINARY(16)                    NULL,

    CONSTRAINT pk_task_priorities
        PRIMARY KEY (pk_task_priority_id),

    CONSTRAINT uq_task_priorities_priority_name
        UNIQUE (priority_name)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE task_priorities;

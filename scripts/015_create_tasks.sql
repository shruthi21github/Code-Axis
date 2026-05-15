/*
===============================================================================
Table       : tasks
Description :
    Stores project tasks and assignments for both employees and students
    through users table.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS tasks
(
    pk_task_id                BINARY(16)                    NOT NULL,

    fk_project_id             BINARY(16)                    NOT NULL,
    fk_user_id                BINARY(16)                    NOT NULL,

    fk_task_status_id         BINARY(16)                    NOT NULL,
    fk_task_priority_id       BINARY(16)                    NOT NULL,

    task_title                VARCHAR(255)                  NOT NULL,
    task_description          TEXT                          NULL,

    estimated_hours           DECIMAL(10,2)                 NULL,
    actual_hours              DECIMAL(10,2)                 NULL,

    start_at                  TIMESTAMP                     NULL,
    deadline_at               TIMESTAMP                     NULL,
    completed_at              TIMESTAMP                     NULL,

    is_active                 BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted                BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at                TIMESTAMP                     NULL,

    created_at                TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                BINARY(16)                    NULL,

    updated_at                TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                             ON UPDATE CURRENT_TIMESTAMP,
    updated_by                BINARY(16)                    NULL,

    CONSTRAINT pk_tasks
        PRIMARY KEY (pk_task_id),

    CONSTRAINT fk_tasks_project_id
        FOREIGN KEY (fk_project_id)
        REFERENCES projects(pk_project_id),

    CONSTRAINT fk_tasks_user_id
        FOREIGN KEY (fk_user_id)
        REFERENCES users(pk_user_id),

    CONSTRAINT fk_tasks_task_status_id
        FOREIGN KEY (fk_task_status_id)
        REFERENCES task_statuses(pk_task_status_id),

    CONSTRAINT fk_tasks_task_priority_id
        FOREIGN KEY (fk_task_priority_id)
        REFERENCES task_priorities(pk_task_priority_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE tasks;

-- ============================================================================
-- Show table DDL
-- ============================================================================

SHOW CREATE TABLE tasks;
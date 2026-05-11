/*
===============================================================================
Table       : task_status_history
Description :
    Historical tracking table for task status changes.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS task_status_history
(
    pk_task_status_history_id       BINARY(16)             NOT NULL,

    fk_task_id                      BINARY(16)             NOT NULL,
    fk_task_status_id               BINARY(16)             NOT NULL,

    changed_at                      TIMESTAMP              NOT NULL DEFAULT CURRENT_TIMESTAMP,

    changed_by                      BINARY(16)             NULL,

    remarks                         VARCHAR(500)           NULL,

    CONSTRAINT pk_task_status_history
        PRIMARY KEY (pk_task_status_history_id),

    CONSTRAINT fk_task_status_history_task_id
        FOREIGN KEY (fk_task_id)
        REFERENCES tasks(pk_task_id),

    CONSTRAINT fk_task_status_history_status_id
        FOREIGN KEY (fk_task_status_id)
        REFERENCES task_statuses(pk_task_status_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE task_status_history;

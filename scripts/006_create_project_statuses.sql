/*
===============================================================================
Table       : project_statuses
Description :
    Master table for project statuses.

Examples:
    - planned
    - active
    - completed
    - on_hold
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS project_statuses
(
    pk_project_status_id      BINARY(16)                    NOT NULL,
    status_name               VARCHAR(100)                  NOT NULL,
    status_description        VARCHAR(255)                  NULL,

    is_active                 BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted                BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at                TIMESTAMP                     NULL,

    created_at                TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                BINARY(16)                    NULL,

    updated_at                TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                             ON UPDATE CURRENT_TIMESTAMP,
    updated_by                BINARY(16)                    NULL,

    CONSTRAINT pk_project_statuses
        PRIMARY KEY (pk_project_status_id),

    CONSTRAINT uq_project_statuses_status_name
        UNIQUE (status_name)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE project_statuses;

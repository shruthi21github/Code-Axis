/*
===============================================================================
Table       : projects
Description :
    Project management table.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS projects
(
    pk_project_id               BINARY(16)                 NOT NULL,

    fk_project_status_id        BINARY(16)                 NOT NULL,

    project_code                VARCHAR(50)                NOT NULL,
    project_name                VARCHAR(255)               NOT NULL,
    project_description         TEXT                       NULL,

    start_at                    TIMESTAMP                  NULL,
    deadline_at                 TIMESTAMP                  NULL,

    is_active                   BOOLEAN                    NOT NULL DEFAULT TRUE,

    is_deleted                  BOOLEAN                    NOT NULL DEFAULT FALSE,
    deleted_at                  TIMESTAMP                  NULL,

    created_at                  TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                  BINARY(16)                 NULL,

    updated_at                  TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                            ON UPDATE CURRENT_TIMESTAMP,
    updated_by                  BINARY(16)                 NULL,

    CONSTRAINT pk_projects
        PRIMARY KEY (pk_project_id),

    CONSTRAINT uq_projects_project_code
        UNIQUE (project_code),

    CONSTRAINT fk_projects_project_status_id
        FOREIGN KEY (fk_project_status_id)
        REFERENCES project_statuses(pk_project_status_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE projects;

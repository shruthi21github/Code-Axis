/*
===============================================================================
Table       : project_member_roles
Description :
    Master table for roles inside a project.

Examples:
    - manager
    - developer
    - tester
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS project_member_roles
(
    pk_project_member_role_id    BINARY(16)                 NOT NULL,
    role_name                    VARCHAR(100)               NOT NULL,
    role_description             VARCHAR(255)               NULL,

    is_active                    BOOLEAN                    NOT NULL DEFAULT TRUE,

    is_deleted                   BOOLEAN                    NOT NULL DEFAULT FALSE,
    deleted_at                   TIMESTAMP                  NULL,

    created_at                   TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                   BINARY(16)                 NULL,

    updated_at                   TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                             ON UPDATE CURRENT_TIMESTAMP,
    updated_by                   BINARY(16)                 NULL,

    CONSTRAINT pk_project_member_roles
        PRIMARY KEY (pk_project_member_role_id),

    CONSTRAINT uq_project_member_roles_role_name
        UNIQUE (role_name)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE project_member_roles;

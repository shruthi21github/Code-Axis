/*
===============================================================================
Table       : permissions
Description :
    Master table storing all system permissions.

Examples:
    - user.create
    - user.update
    - task.assign
    - report.export
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS permissions
(
    pk_permission_id         BINARY(16)                    NOT NULL,
    module_name              VARCHAR(100)                  NOT NULL,
    action_name              VARCHAR(100)                  NOT NULL,
    permission_name          VARCHAR(150)                  NOT NULL,
    permission_description   VARCHAR(255)                  NULL,

    is_active                BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted               BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at               TIMESTAMP                     NULL,

    created_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by               BINARY(16)                    NULL,

    updated_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                            ON UPDATE CURRENT_TIMESTAMP,
    updated_by               BINARY(16)                    NULL,

    CONSTRAINT pk_permissions
        PRIMARY KEY (pk_permission_id),

    CONSTRAINT uq_permissions_permission_name
        UNIQUE (permission_name),

    CONSTRAINT uq_permissions_module_name_action_name
        UNIQUE (module_name, action_name)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE permissions;

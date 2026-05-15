/*
===============================================================================
Table       : role_permissions
Description :
    Mapping table between roles and permissions.

Examples:
    ADMIN
        -> user.create
        -> user.delete

    EMPLOYEE
        -> task.read
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS role_permissions
(
    pk_role_permission_id    BINARY(16)                    NOT NULL,

    fk_role_id               BINARY(16)                    NOT NULL,
    fk_permission_id         BINARY(16)                    NOT NULL,

    is_active                BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted               BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at               TIMESTAMP                     NULL,

    created_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by               BINARY(16)                    NULL,

    updated_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                            ON UPDATE CURRENT_TIMESTAMP,
    updated_by               BINARY(16)                    NULL,

    CONSTRAINT pk_role_permissions
        PRIMARY KEY (pk_role_permission_id),

    CONSTRAINT uq_role_permissions_role_permission
        UNIQUE (fk_role_id, fk_permission_id),

    CONSTRAINT fk_role_permissions_role_id
        FOREIGN KEY (fk_role_id)
        REFERENCES roles (pk_role_id),

    CONSTRAINT fk_role_permissions_permission_id
        FOREIGN KEY (fk_permission_id)
        REFERENCES permissions (pk_permission_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE role_permissions;

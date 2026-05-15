/*
===============================================================================
Table       : roles
Description :
    Master table for application roles.

Examples:
    - ADMIN
    - EMPLOYEE
    - CLIENT
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS roles
(
    pk_role_id            BINARY(16)                    NOT NULL,
    role_name             VARCHAR(100)                  NOT NULL,
    role_description      VARCHAR(255)                  NULL,
    role_level            INT                           NOT NULL,
    
    is_active             BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted            BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at            TIMESTAMP                     NULL,

    created_at            TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by            BINARY(16)                    NULL,

    updated_at            TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                         ON UPDATE CURRENT_TIMESTAMP,
    updated_by            BINARY(16)                    NULL,

    CONSTRAINT pk_roles
        PRIMARY KEY (pk_role_id),

    CONSTRAINT uq_roles_role_name
        UNIQUE (role_name)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE roles;

-- ============================================================================
-- SHOW CREATE TABLE
-- ============================================================================

SHOW CREATE TABLE roles;

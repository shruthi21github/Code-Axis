/*
===============================================================================
Table       : departments
Description :
    Master table for employee departments.

Examples:
    - HR
    - Development
    - QA
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS departments
(
    pk_department_id        BINARY(16)                    NOT NULL,
    department_name         VARCHAR(100)                  NOT NULL,
    department_description  VARCHAR(255)                  NULL,

    is_active               BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted              BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at              TIMESTAMP                     NULL,

    created_at              TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by              BINARY(16)                    NULL,

    updated_at              TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                           ON UPDATE CURRENT_TIMESTAMP,
    updated_by              BINARY(16)                    NULL,

    CONSTRAINT pk_departments
        PRIMARY KEY (pk_department_id),

    CONSTRAINT uq_departments_department_name
        UNIQUE (department_name)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE departments;

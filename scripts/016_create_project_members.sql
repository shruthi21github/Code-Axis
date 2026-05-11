/*
===============================================================================
Table       : project_members
Description :
    Bridge table for employee-project assignments.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS project_members
(
    pk_project_member_id           BINARY(16)              NOT NULL,

    fk_project_id                  BINARY(16)              NOT NULL,
    fk_employee_id                 BINARY(16)              NOT NULL,
    fk_project_member_role_id      BINARY(16)              NOT NULL,

    assigned_at                    TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP,

    is_active                      BOOLEAN                 NOT NULL DEFAULT TRUE,

    created_at                     TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                     BINARY(16)              NULL,

    CONSTRAINT pk_project_members
        PRIMARY KEY (pk_project_member_id),

    CONSTRAINT uq_project_members_project_employee
        UNIQUE (fk_project_id, fk_employee_id),

    CONSTRAINT fk_project_members_project_id
        FOREIGN KEY (fk_project_id)
        REFERENCES projects(pk_project_id),

    CONSTRAINT fk_project_members_employee_id
        FOREIGN KEY (fk_employee_id)
        REFERENCES employees(pk_employee_id),

    CONSTRAINT fk_project_members_project_member_role_id
        FOREIGN KEY (fk_project_member_role_id)
        REFERENCES project_member_roles(pk_project_member_role_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE project_members;

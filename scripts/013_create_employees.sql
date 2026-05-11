/*
===============================================================================
Table       : employees
Description :
    Employee business profile information table.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS employees
(
    pk_employee_id              BINARY(16)                 NOT NULL,

    fk_user_id                  BINARY(16)                 NOT NULL,
    fk_department_id            BINARY(16)                 NOT NULL,
    fk_designation_id           BINARY(16)                 NOT NULL,

    fk_manager_employee_id      BINARY(16)                 NULL,

    employee_code               VARCHAR(50)                NOT NULL,

    first_name                  VARCHAR(100)               NOT NULL,
    last_name                   VARCHAR(100)               NOT NULL,

    date_of_birth               DATE                       NULL,
    joining_date                DATE                       NOT NULL,

    salary                      DECIMAL(15,2)              NULL,

    is_active                   BOOLEAN                    NOT NULL DEFAULT TRUE,

    is_deleted                  BOOLEAN                    NOT NULL DEFAULT FALSE,
    deleted_at                  TIMESTAMP                  NULL,

    created_at                  TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                  BINARY(16)                 NULL,

    updated_at                  TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                            ON UPDATE CURRENT_TIMESTAMP,
    updated_by                  BINARY(16)                 NULL,

    CONSTRAINT pk_employees
        PRIMARY KEY (pk_employee_id),

    CONSTRAINT uq_employees_fk_user_id
        UNIQUE (fk_user_id),

    CONSTRAINT uq_employees_employee_code
        UNIQUE (employee_code),

    CONSTRAINT fk_employees_user_id
        FOREIGN KEY (fk_user_id)
        REFERENCES users(pk_user_id),

    CONSTRAINT fk_employees_department_id
        FOREIGN KEY (fk_department_id)
        REFERENCES departments(pk_department_id),

    CONSTRAINT fk_employees_designation_id
        FOREIGN KEY (fk_designation_id)
        REFERENCES designations(pk_designation_id),

    CONSTRAINT fk_employees_manager_employee_id
        FOREIGN KEY (fk_manager_employee_id)
        REFERENCES employees(pk_employee_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE employees;

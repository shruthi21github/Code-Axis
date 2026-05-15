/*
===============================================================================
Table       : students
Description :
    Stores student profile and academic information.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS students
(
    pk_student_id                    BINARY(16)                    NOT NULL,

    fk_user_id                       BINARY(16)                    NOT NULL,
    fk_department_id                 BINARY(16)                    NOT NULL,
    fk_course_id                     BINARY(16)                    NOT NULL,
    fk_student_status_id             BINARY(16)                    NOT NULL,

    fk_employee_id                   BINARY(16)                    NULL,

    student_code                     VARCHAR(50)                   NOT NULL,

    first_name                       VARCHAR(100)                  NOT NULL,
    last_name                        VARCHAR(100)                  NOT NULL,

    date_of_birth                    DATE                          NULL,

    joining_date                     DATE                          NOT NULL,

    academic_year                    TINYINT                       NULL,
    semester                         TINYINT                       NULL,

    passed_out_year                  YEAR                          NULL,

    cgpa                             DECIMAL(5,2)                  NULL,

    emergency_contact_name           VARCHAR(100)                  NULL,
    emergency_contact_phone_number   VARCHAR(20)                   NULL,

    address_line_1                   VARCHAR(255)                  NULL,
    address_line_2                   VARCHAR(255)                  NULL,

    city                             VARCHAR(100)                  NULL,
    state                            VARCHAR(100)                  NULL,
    postal_code                      VARCHAR(20)                   NULL,
    country                          VARCHAR(100)                  NULL,

    is_active                        BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted                       BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at                       TIMESTAMP                     NULL,

    created_at                       TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                       BINARY(16)                    NULL,

    updated_at                       TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                                    ON UPDATE CURRENT_TIMESTAMP,
    updated_by                       BINARY(16)                    NULL,

    CONSTRAINT pk_students
        PRIMARY KEY (pk_student_id),

    CONSTRAINT uq_students_user_id
        UNIQUE (fk_user_id),

    CONSTRAINT uq_students_student_code
        UNIQUE (student_code),

    CONSTRAINT fk_students_user_id
        FOREIGN KEY (fk_user_id)
        REFERENCES users(pk_user_id),

    CONSTRAINT fk_students_department_id
        FOREIGN KEY (fk_department_id)
        REFERENCES departments(pk_department_id),

    CONSTRAINT fk_students_course_id
        FOREIGN KEY (fk_course_id)
        REFERENCES courses(pk_course_id),

    CONSTRAINT fk_students_student_status_id
        FOREIGN KEY (fk_student_status_id)
        REFERENCES student_statuses(pk_student_status_id),

    CONSTRAINT fk_students_employee_id
        FOREIGN KEY (fk_employee_id)
        REFERENCES employees(pk_employee_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE students;

-- ============================================================================
-- Show table DDL
-- ============================================================================

SHOW CREATE TABLE students;
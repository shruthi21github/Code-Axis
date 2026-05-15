/*
===============================================================================
Table       : courses
Description :
    Stores normalized course/program information.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS courses
(
    pk_course_id             BINARY(16)                    NOT NULL,

    fk_department_id         BINARY(16)                    NOT NULL,
    fk_duration_unit_id      BINARY(16)                    NOT NULL,

    course_name              VARCHAR(255)                  NOT NULL,
    course_description       TEXT                          NULL,

    duration_value           INT                           NOT NULL,

    fees_amount              DECIMAL(15,2)                 NULL,

    max_students             INT                           NULL,

    start_date               DATE                          NULL,
    end_date                 DATE                          NULL,

    is_active                BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted               BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at               TIMESTAMP                     NULL,

    created_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by               BINARY(16)                    NULL,

    updated_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                            ON UPDATE CURRENT_TIMESTAMP,
    updated_by               BINARY(16)                    NULL,

    CONSTRAINT pk_courses
        PRIMARY KEY (pk_course_id),

    CONSTRAINT uq_courses_course_name
        UNIQUE (course_name),

    CONSTRAINT fk_courses_department_id
        FOREIGN KEY (fk_department_id)
        REFERENCES departments(pk_department_id),

    CONSTRAINT fk_courses_duration_unit_id
        FOREIGN KEY (fk_duration_unit_id)
        REFERENCES duration_units(pk_duration_unit_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE courses;

-- ============================================================================
-- Show table DDL
-- ============================================================================

SHOW CREATE TABLE courses;
/*
===============================================================================
Table       : report_types
Description :
    Master table for report types.

Examples:
    - attendance_report
    - performance_report
    - project_report
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS report_types
(
    pk_report_type_id         BINARY(16)                   NOT NULL,
    type_name                 VARCHAR(100)                 NOT NULL,
    type_description          VARCHAR(255)                 NULL,

    is_active                 BOOLEAN                      NOT NULL DEFAULT TRUE,

    is_deleted                BOOLEAN                      NOT NULL DEFAULT FALSE,
    deleted_at                TIMESTAMP                    NULL,

    created_at                TIMESTAMP                    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                BINARY(16)                   NULL,

    updated_at                TIMESTAMP                    NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                            ON UPDATE CURRENT_TIMESTAMP,
    updated_by                BINARY(16)                   NULL,

    CONSTRAINT pk_report_types
        PRIMARY KEY (pk_report_type_id),

    CONSTRAINT uq_report_types_type_name
        UNIQUE (type_name)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE report_types;
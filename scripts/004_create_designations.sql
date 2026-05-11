/*
===============================================================================
Table       : designations
Description :
    Master table for employee job titles/designations.

Examples:
    - Junior Developer
    - Team Lead
    - Project Manager
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS designations
(
    pk_designation_id        BINARY(16)                    NOT NULL,
    designation_name         VARCHAR(100)                  NOT NULL,
    designation_description  VARCHAR(255)                  NULL,

    is_active                BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted               BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at               TIMESTAMP                     NULL,

    created_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by               BINARY(16)                    NULL,

    updated_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                            ON UPDATE CURRENT_TIMESTAMP,
    updated_by               BINARY(16)                    NULL,

    CONSTRAINT pk_designations
        PRIMARY KEY (pk_designation_id),

    CONSTRAINT uq_designations_designation_name
        UNIQUE (designation_name)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE designations;

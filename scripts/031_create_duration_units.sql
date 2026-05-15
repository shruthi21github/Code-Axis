/*
===============================================================================
Table       : duration_units
Description :
    Lookup table for normalized course duration units.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS duration_units
(
    pk_duration_unit_id      BINARY(16)                    NOT NULL,

    unit_name                VARCHAR(50)                   NOT NULL,
    unit_description         VARCHAR(255)                  NULL,

    is_active                BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted               BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at               TIMESTAMP                     NULL,

    created_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by               BINARY(16)                    NULL,

    updated_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                            ON UPDATE CURRENT_TIMESTAMP,
    updated_by               BINARY(16)                    NULL,

    CONSTRAINT pk_duration_units
        PRIMARY KEY (pk_duration_unit_id),

    CONSTRAINT uq_duration_units_unit_name
        UNIQUE (unit_name)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE duration_units;

-- ============================================================================
-- Show table DDL
-- ============================================================================

SHOW CREATE TABLE duration_units;

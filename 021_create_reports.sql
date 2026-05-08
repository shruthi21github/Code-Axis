/*
===============================================================================
Table       : reports
Description :
    Report metadata storage table.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS reports
(
    pk_report_id                BINARY(16)                 NOT NULL,

    fk_user_id                  BINARY(16)                 NOT NULL,
    fk_report_type_id           BINARY(16)                 NOT NULL,

    report_name                 VARCHAR(255)               NOT NULL,

    file_name                   VARCHAR(255)               NOT NULL,
    file_path                   VARCHAR(500)               NOT NULL,

    generated_at                TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,

    created_at                  TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                  BINARY(16)                 NULL,

    CONSTRAINT pk_reports
        PRIMARY KEY (pk_report_id),

    CONSTRAINT fk_reports_user_id
        FOREIGN KEY (fk_user_id)
        REFERENCES users(pk_user_id),

    CONSTRAINT fk_reports_report_type_id
        FOREIGN KEY (fk_report_type_id)
        REFERENCES report_types(pk_report_type_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE reports;

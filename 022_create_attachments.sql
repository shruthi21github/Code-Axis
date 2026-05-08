/*
===============================================================================
Table       : attachments
Description :
    Generic attachment storage metadata table.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS attachments
(
    pk_attachment_id            BINARY(16)                 NOT NULL,

    fk_user_id                  BINARY(16)                 NOT NULL,

    entity_type                 VARCHAR(100)               NOT NULL,
    entity_id                   BINARY(16)                 NOT NULL,

    file_name                   VARCHAR(255)               NOT NULL,
    file_path                   VARCHAR(500)               NOT NULL,

    mime_type                   VARCHAR(100)               NULL,
    file_size                   BIGINT                     NULL,

    uploaded_at                 TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,

    is_active                   BOOLEAN                    NOT NULL DEFAULT TRUE,

    is_deleted                  BOOLEAN                    NOT NULL DEFAULT FALSE,
    deleted_at                  TIMESTAMP                  NULL,

    created_at                  TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                  BINARY(16)                 NULL,

    CONSTRAINT pk_attachments
        PRIMARY KEY (pk_attachment_id),

    CONSTRAINT fk_attachments_user_id
        FOREIGN KEY (fk_user_id)
        REFERENCES users(pk_user_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE attachments;

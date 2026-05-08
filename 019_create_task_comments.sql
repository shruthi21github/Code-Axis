/*
===============================================================================
Table       : task_comments
Description :
    Task discussion and comment table.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS task_comments
(
    pk_task_comment_id          BINARY(16)                 NOT NULL,

    fk_task_id                  BINARY(16)                 NOT NULL,
    fk_user_id                  BINARY(16)                 NOT NULL,

    comment_text                TEXT                       NOT NULL,

    is_edited                   BOOLEAN                    NOT NULL DEFAULT FALSE,
    edited_at                   TIMESTAMP                  NULL,

    created_at                  TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                  BINARY(16)                 NULL,

    CONSTRAINT pk_task_comments
        PRIMARY KEY (pk_task_comment_id),

    CONSTRAINT fk_task_comments_task_id
        FOREIGN KEY (fk_task_id)
        REFERENCES tasks(pk_task_id),

    CONSTRAINT fk_task_comments_user_id
        FOREIGN KEY (fk_user_id)
        REFERENCES users(pk_user_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE task_comments;

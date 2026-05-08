/*
===============================================================================
Table       : password_reset_tokens
Description :
    Password reset token management table.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS password_reset_tokens
(
    pk_password_reset_token_id     BINARY(16)              NOT NULL,

    fk_user_id                     BINARY(16)              NOT NULL,

    reset_token_hash               VARCHAR(255)            NOT NULL,

    expires_at                     TIMESTAMP               NOT NULL,
    used_at                        TIMESTAMP               NULL,

    is_active                      BOOLEAN                 NOT NULL DEFAULT TRUE,

    created_at                     TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_password_reset_tokens
        PRIMARY KEY (pk_password_reset_token_id),

    CONSTRAINT fk_password_reset_tokens_user_id
        FOREIGN KEY (fk_user_id)
        REFERENCES users(pk_user_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE password_reset_tokens;

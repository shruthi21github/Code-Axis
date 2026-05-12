/*
===============================================================================
Table       : email_verification_tokens
Description :
    Email verification token management table.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS email_verification_tokens
(
    pk_email_verification_token_id     BINARY(16)          NOT NULL,

    fk_user_id                         BINARY(16)          NOT NULL,

    verification_token_hash            VARCHAR(255)        NOT NULL,

    expires_at                         TIMESTAMP           NOT NULL,
    verified_at                        TIMESTAMP           NULL,

    is_active                          BOOLEAN             NOT NULL DEFAULT TRUE,

    created_at                         TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_email_verification_tokens
        PRIMARY KEY (pk_email_verification_token_id),

    CONSTRAINT fk_email_verification_tokens_user_id
        FOREIGN KEY (fk_user_id)
        REFERENCES users(pk_user_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE email_verification_tokens;

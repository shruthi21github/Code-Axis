/*
===============================================================================
Table       : user_sessions
Description :
    Active session and JWT tracking table.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS user_sessions
(
    pk_user_session_id          BINARY(16)                 NOT NULL,

    fk_user_id                  BINARY(16)                 NOT NULL,

    refresh_token_hash          VARCHAR(255)               NOT NULL,

    refresh_token_expires_at    TIMESTAMP                  NOT NULL,
    revoked_at                  TIMESTAMP                  NULL,

    is_active                   BOOLEAN                    NOT NULL DEFAULT TRUE,

    created_at                  TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                  BINARY(16)                 NULL,

    CONSTRAINT pk_user_sessions
        PRIMARY KEY (pk_user_session_id),

    CONSTRAINT fk_user_sessions_user_id
        FOREIGN KEY (fk_user_id)
        REFERENCES users(pk_user_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE user_sessions;

-- ============================================================================
-- Alter
-- ============================================================================

-- rename only if required

-- ALTER TABLE user_sessions
-- RENAME COLUMN expires_at TO refresh_token_expires_at;

-- ALTER TABLE user_sessions
-- RENAME COLUMN jwt_token_hash TO refresh_token_hash;

/*
===============================================================================
Table       : users
Description :
    Authentication and account management table.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS users
(
    pk_user_id               BINARY(16)                    NOT NULL,

    fk_role_id               BINARY(16)                    NOT NULL,

    username                 VARCHAR(100)                  NOT NULL,
    email                    VARCHAR(255)                  NOT NULL,
    phone_number             VARCHAR(20)                   NULL,

    password_hash            VARCHAR(255)                  NOT NULL,
    
	is_email_verified        BOOLEAN                       NOT NULL DEFAULT FALSE,
	email_verified_at        TIMESTAMP                     NULL,

    is_locked                BOOLEAN                       NOT NULL DEFAULT FALSE,
    locked_at                TIMESTAMP                     NULL,

    last_login_at            TIMESTAMP                     NULL,

    is_active                BOOLEAN                       NOT NULL DEFAULT TRUE,

    is_deleted               BOOLEAN                       NOT NULL DEFAULT FALSE,
    deleted_at               TIMESTAMP                     NULL,

    created_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by               BINARY(16)                    NULL,

    updated_at               TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                                            ON UPDATE CURRENT_TIMESTAMP,
    updated_by               BINARY(16)                    NULL,

    CONSTRAINT pk_users
        PRIMARY KEY (pk_user_id),

    CONSTRAINT uq_users_username
        UNIQUE (username),

    CONSTRAINT uq_users_email
        UNIQUE (email),

    CONSTRAINT fk_users_role_id
        FOREIGN KEY (fk_role_id)
        REFERENCES roles(pk_role_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE users;

-- ============================================================================
-- Show table DDL
-- ============================================================================

SHOW CREATE TABLE users;

-- ============================================================================
-- Alter
-- ============================================================================

-- only add if not present

-- ALTER TABLE users
-- ADD COLUMN is_email_verified BOOLEAN NOT NULL DEFAULT FALSE,
-- ADD COLUMN email_verified_at TIMESTAMP NULL;




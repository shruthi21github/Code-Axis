/*
===============================================================================
TEST FILE
Procedure : 001_sp_auth_register_user
===============================================================================

Covers:
1. Successful registration
2. Username normalization
3. Email normalization
4. Username already exists
5. Email already exists
6. Invalid username
7. Invalid email
8. Invalid password hash
9. Invalid role name
10. Inactive role
11. Deleted role
12. Invalid verification token hash
13. Invalid verification token expiry
14. Token revocation validation
15. Result enrichment validation

===============================================================================
*/


/*
===============================================================================
CREATE DATABASE
===============================================================================
*/

DROP DATABASE IF EXISTS test_auth_db;

CREATE DATABASE test_auth_db;

USE test_auth_db;


/*
===============================================================================
CREATE ROLES TABLE
===============================================================================
*/

DROP TABLE IF EXISTS roles;

CREATE TABLE roles
(
    pk_role_id         BINARY(16) PRIMARY KEY,

    role_name          VARCHAR(100),

    is_active          BOOLEAN,
    is_deleted         BOOLEAN
);


/*
===============================================================================
CREATE USERS TABLE
===============================================================================
*/

DROP TABLE IF EXISTS users;

CREATE TABLE users
(
    pk_user_id                     BINARY(16) PRIMARY KEY,
    fk_role_id                     BINARY(16),

    username                       VARCHAR(100),
    email                          VARCHAR(255),

    password_hash                  VARCHAR(255),

    is_email_verified              BOOLEAN,

    is_locked                      BOOLEAN,
    locked_at                      TIMESTAMP NULL,

    last_login_at                  TIMESTAMP NULL,

    is_active                      BOOLEAN,

    is_deleted                     BOOLEAN,
    deleted_at                     TIMESTAMP NULL,

    created_at                     TIMESTAMP,
    created_by                     BINARY(16) NULL,

    updated_at                     TIMESTAMP,
    updated_by                     BINARY(16) NULL
);


/*
===============================================================================
CREATE EMAIL VERIFICATION TOKENS TABLE
===============================================================================
*/

DROP TABLE IF EXISTS email_verification_tokens;

CREATE TABLE email_verification_tokens
(
    pk_email_verification_token_id     BINARY(16) PRIMARY KEY,
    fk_user_id                         BINARY(16),

    verification_token_hash            VARCHAR(255),

    expires_at                         TIMESTAMP,
    verified_at                        TIMESTAMP NULL,

    is_active                          BOOLEAN,

    created_at                         TIMESTAMP
);


/*
===============================================================================
INSERT ROLES
===============================================================================
*/

SET @admin_role_id = UUID_TO_BIN(UUID(), TRUE);
SET @user_role_id = UUID_TO_BIN(UUID(), TRUE);
SET @inactive_role_id = UUID_TO_BIN(UUID(), TRUE);
SET @deleted_role_id = UUID_TO_BIN(UUID(), TRUE);

INSERT INTO roles
(
    pk_role_id,
    role_name,

    is_active,
    is_deleted
)
VALUES

(
    @admin_role_id,
    'ADMIN',

    TRUE,
    FALSE
),

(
    @user_role_id,
    'USER',

    TRUE,
    FALSE
),

(
    @inactive_role_id,
    'INACTIVE_ROLE',

    FALSE,
    FALSE
),

(
    @deleted_role_id,
    'DELETED_ROLE',

    TRUE,
    TRUE
);


/*
===============================================================================
INSERT EXISTING USER
===============================================================================
*/

SET @existing_user_id = UUID_TO_BIN(UUID(), TRUE);

INSERT INTO users
(
    pk_user_id,
    fk_role_id,

    username,
    email,

    password_hash,

    is_email_verified,

    is_locked,
    locked_at,

    last_login_at,

    is_active,

    is_deleted,
    deleted_at,

    created_at,
    created_by,

    updated_at,
    updated_by
)
VALUES
(
    @existing_user_id,
    @user_role_id,

    'existing_user',
    'existing@test.com',

    'hashed_existing_password',

    TRUE,

    FALSE,
    NULL,

    NULL,

    TRUE,

    FALSE,
    NULL,

    CURRENT_TIMESTAMP,
    NULL,

    CURRENT_TIMESTAMP,
    NULL
);


/*
===============================================================================
INSERT ACTIVE TOKEN FOR REVOCATION TEST
===============================================================================
*/

INSERT INTO email_verification_tokens
(
    pk_email_verification_token_id,
    fk_user_id,

    verification_token_hash,

    expires_at,
    verified_at,

    is_active,

    created_at
)
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    @existing_user_id,

    'old_active_token',

    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY),
    NULL,

    TRUE,

    CURRENT_TIMESTAMP
);


/*
===============================================================================
CREATE PROCEDURE
===============================================================================
*/

-- PASTE PROCEDURE HERE


/*
===============================================================================
TEST CASE 1
SUCCESSFUL REGISTRATION
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'john',
    'john@test.com',

    'hashed_password_john',

    'USER',

    'verification_hash_001',
    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
);


/*
===============================================================================
TEST CASE 2
USERNAME NORMALIZATION
EXPECTED:
username stored as lowercase trimmed
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    '   JOHNNY   ',
    'johnny@test.com',

    'hashed_password_johnny',

    'USER',

    'verification_hash_002',
    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
);

SELECT username
FROM users
WHERE email = 'johnny@test.com';


/*
===============================================================================
TEST CASE 3
EMAIL NORMALIZATION
EXPECTED:
email stored lowercase trimmed
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'email_normalized',
    '   EMAIL@TEST.COM   ',

    'hashed_password_email',

    'USER',

    'verification_hash_003',
    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
);

SELECT email
FROM users
WHERE username = 'email_normalized';


/*
===============================================================================
TEST CASE 4
USERNAME ALREADY EXISTS
EXPECTED:
Username already exists
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'existing_user',
    'newemail@test.com',

    'hashed_password',

    'USER',

    'verification_hash_004',
    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
);


/*
===============================================================================
TEST CASE 5
EMAIL ALREADY EXISTS
EXPECTED:
Email address already exists
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'new_username',
    'existing@test.com',

    'hashed_password',

    'USER',

    'verification_hash_005',
    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
);


/*
===============================================================================
TEST CASE 6
INVALID USERNAME
EXPECTED:
Invalid username
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    '',
    'invaliduser@test.com',

    'hashed_password',

    'USER',

    'verification_hash_006',
    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
);


/*
===============================================================================
TEST CASE 7
INVALID EMAIL
EXPECTED:
Invalid email address
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'invalid_email_user',
    '',

    'hashed_password',

    'USER',

    'verification_hash_007',
    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
);


/*
===============================================================================
TEST CASE 8
INVALID PASSWORD HASH
EXPECTED:
Invalid password hash
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'invalid_password_user',
    'invalidpassword@test.com',

    '',

    'USER',

    'verification_hash_008',
    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
);


/*
===============================================================================
TEST CASE 9
ROLE NOT FOUND
EXPECTED:
User role not found
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'missing_role_user',
    'missingrole@test.com',

    'hashed_password',

    'GHOST_ROLE',

    'verification_hash_009',
    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
);


/*
===============================================================================
TEST CASE 10
ROLE INACTIVE
EXPECTED:
User role inactive
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'inactive_role_user',
    'inactiverole@test.com',

    'hashed_password',

    'INACTIVE_ROLE',

    'verification_hash_010',
    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
);


/*
===============================================================================
TEST CASE 11
ROLE DELETED
EXPECTED:
User role deleted
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'deleted_role_user',
    'deletedrole@test.com',

    'hashed_password',

    'DELETED_ROLE',

    'verification_hash_011',
    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
);


/*
===============================================================================
TEST CASE 12
INVALID TOKEN HASH
EXPECTED:
Verification token invalid
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'invalid_token_hash_user',
    'invalidtoken@test.com',

    'hashed_password',

    'USER',

    '',

    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
);


/*
===============================================================================
TEST CASE 13
INVALID TOKEN EXPIRY
EXPECTED:
Verification token invalid
===============================================================================
*/

CALL 001_sp_auth_register_user
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'invalid_expiry_user',
    'invalidexpiry@test.com',

    'hashed_password',

    'USER',

    'verification_hash_013',

    NULL
);


/*
===============================================================================
TEST CASE 14
VERIFY TOKEN INSERTION
===============================================================================
*/

SELECT *
FROM email_verification_tokens
ORDER BY created_at DESC;


/*
===============================================================================
TEST CASE 15
VERIFY TEMP TABLE CLEANUP
===============================================================================
*/

SHOW TABLES LIKE 'tmp_%';


/*
===============================================================================
OPTIONAL CLEANUP
===============================================================================
*/

-- DROP DATABASE test_register_db;
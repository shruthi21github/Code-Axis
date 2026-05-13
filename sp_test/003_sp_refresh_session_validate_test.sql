/*
===============================================================================
TEST FILE
Procedure : sp_refresh_session_validate
===============================================================================

Covers:
1. Valid refresh token
2. Invalid token
3. Expired token
4. Revoked token
5. Inactive session
6. Duplicate token edge case
7. Temp table cleanup validation

===============================================================================
CREATE DATABASE
===============================================================================
*/

DROP DATABASE IF EXISTS test_refresh_session_db;

CREATE DATABASE test_refresh_session_db;

USE test_refresh_session_db;


/*
===============================================================================
CREATE USER SESSIONS TABLE
===============================================================================
*/

DROP TABLE IF EXISTS user_sessions;

CREATE TABLE user_sessions
(
    pk_user_session_id            BINARY(16) PRIMARY KEY,
    fk_user_id                    BINARY(16),

    refresh_token_hash            VARCHAR(255),

    refresh_token_expires_at      TIMESTAMP,

    revoked_at                    TIMESTAMP NULL,

    is_active                     BOOLEAN
);


/*
===============================================================================
INSERT VALID SESSION
===============================================================================
*/

INSERT INTO user_sessions
(
    pk_user_session_id,
    fk_user_id,

    refresh_token_hash,

    refresh_token_expires_at,

    revoked_at,

    is_active
)
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'valid_token',

    DATE_ADD(NOW(), INTERVAL 1 DAY),

    NULL,

    TRUE
);


/*
===============================================================================
INSERT EXPIRED SESSION
===============================================================================
*/

INSERT INTO user_sessions
(
    pk_user_session_id,
    fk_user_id,

    refresh_token_hash,

    refresh_token_expires_at,

    revoked_at,

    is_active
)
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'expired_token',

    DATE_SUB(NOW(), INTERVAL 1 DAY),

    NULL,

    TRUE
);


/*
===============================================================================
INSERT REVOKED SESSION
===============================================================================
*/

INSERT INTO user_sessions
(
    pk_user_session_id,
    fk_user_id,

    refresh_token_hash,

    refresh_token_expires_at,

    revoked_at,

    is_active
)
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'revoked_token',

    DATE_ADD(NOW(), INTERVAL 1 DAY),

    NOW(),

    TRUE
);


/*
===============================================================================
INSERT INACTIVE SESSION
===============================================================================
*/

INSERT INTO user_sessions
(
    pk_user_session_id,
    fk_user_id,

    refresh_token_hash,

    refresh_token_expires_at,

    revoked_at,

    is_active
)
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'inactive_token',

    DATE_ADD(NOW(), INTERVAL 1 DAY),

    NULL,

    FALSE
);


/*
===============================================================================
CREATE PROCEDURE
===============================================================================
*/

DROP PROCEDURE IF EXISTS sp_refresh_session_validate;

DELIMITER $$

CREATE PROCEDURE sp_refresh_session_validate
(
    IN p_token_hash VARCHAR(255)
)
BEGIN

    /*
    ===========================================================================
    VARIABLES
    ===========================================================================
    */

    DECLARE v_row_count INT DEFAULT 0;

    /*
    ===========================================================================
    ERROR HANDLER
    ===========================================================================
    */

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN

        GET DIAGNOSTICS CONDITION 1
            @p1 = MESSAGE_TEXT;

        ROLLBACK;

        DROP TEMPORARY TABLE IF EXISTS tmp_session;

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = @p1;

    END;

    /*
    ===========================================================================
    START TRANSACTION
    ===========================================================================
    */

    START TRANSACTION;

    /*
    ===========================================================================
    DROP TEMP TABLE IF EXISTS
    ===========================================================================
    */

    DROP TEMPORARY TABLE IF EXISTS tmp_session;

    /*
    ===========================================================================
    CREATE TEMP TABLE
    ===========================================================================
    */

    CREATE TEMPORARY TABLE tmp_session
    (
        pk_user_session_id            BINARY(16),
        fk_user_id                    BINARY(16),

        refresh_token_expires_at      TIMESTAMP,

        revoked_at                    TIMESTAMP,

        is_active                     BOOLEAN
    );

    /*
    ===========================================================================
    INSERT VALID SESSION
    ===========================================================================
    */

    INSERT INTO tmp_session
    (
        pk_user_session_id,
        fk_user_id,

        refresh_token_expires_at,

        revoked_at,

        is_active
    )
    SELECT
        us.pk_user_session_id,
        us.fk_user_id,

        us.refresh_token_expires_at,

        us.revoked_at,

        us.is_active
    FROM user_sessions us
    WHERE us.refresh_token_hash = p_token_hash
      AND us.is_active = TRUE
      AND us.revoked_at IS NULL
      AND us.refresh_token_expires_at > NOW()
    LIMIT 1;

    /*
    ===========================================================================
    VALIDATE ROW EXISTS
    ===========================================================================
    */

    SELECT COUNT(*)
    INTO v_row_count
    FROM tmp_session;

    IF v_row_count = 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Invalid or expired refresh token';

    END IF;

    /*
    ===========================================================================
    RETURN RESULT
    ===========================================================================
    */

    SELECT
        BIN_TO_UUID(pk_user_session_id, TRUE) AS user_session_id,
        BIN_TO_UUID(fk_user_id, TRUE) AS user_id,

        refresh_token_expires_at,

        revoked_at,

        is_active
    FROM tmp_session;

    /*
    ===========================================================================
    CLEANUP
    ===========================================================================
    */

    DROP TEMPORARY TABLE IF EXISTS tmp_session;

    COMMIT;

END $$

DELIMITER ;


/*
===============================================================================
TEST CASE 1
VALID TOKEN
EXPECTED:
1 ROW RETURNED
===============================================================================
*/

CALL sp_refresh_session_validate('valid_token');


/*
===============================================================================
TEST CASE 2
INVALID TOKEN
EXPECTED:
Invalid or expired refresh token
===============================================================================
*/

CALL sp_refresh_session_validate('ghost_token');


/*
===============================================================================
TEST CASE 3
EXPIRED TOKEN
EXPECTED:
Invalid or expired refresh token
===============================================================================
*/

CALL sp_refresh_session_validate('expired_token');


/*
===============================================================================
TEST CASE 4
REVOKED TOKEN
EXPECTED:
Invalid or expired refresh token
===============================================================================
*/

CALL sp_refresh_session_validate('revoked_token');


/*
===============================================================================
TEST CASE 5
INACTIVE SESSION
EXPECTED:
Invalid or expired refresh token
===============================================================================
*/

CALL sp_refresh_session_validate('inactive_token');


/*
===============================================================================
TEST CASE 6
DUPLICATE TOKEN EDGE CASE
EXPECTED:
1 RANDOM ROW DUE TO LIMIT 1
===============================================================================
*/

INSERT INTO user_sessions
(
    pk_user_session_id,
    fk_user_id,

    refresh_token_hash,

    refresh_token_expires_at,

    revoked_at,

    is_active
)
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    UUID_TO_BIN(UUID(), TRUE),

    'valid_token',

    DATE_ADD(NOW(), INTERVAL 1 DAY),

    NULL,

    TRUE
);

CALL sp_refresh_session_validate('valid_token');


/*
===============================================================================
TEST CASE 7
VERIFY TEMP TABLE CLEANUP
EXPECTED:
EMPTY RESULT
===============================================================================
*/

SHOW TABLES LIKE 'tmp_%';


/*
===============================================================================
OPTIONAL CLEANUP
===============================================================================
*/

-- DROP DATABASE test_refresh_session_db;
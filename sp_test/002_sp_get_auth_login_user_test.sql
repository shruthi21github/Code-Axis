/*
===============================================================================
TEST FILE
Procedure : 001_sp_get_auth_login_user
===============================================================================

Covers:
1. Success login by username
2. Success login by email
3. Username trimming
4. Case insensitive login
5. User not found
6. Inactive account
7. Deleted account
8. Locked account
9. Email not verified
10. Role join validation
11. Duplicate username edge case
12. Null role join edge case

Based on uploaded procedure
:contentReference[oaicite:0]{index=0}
===============================================================================
*/


/*
===============================================================================
CREATE DATABASE
===============================================================================
*/

-- DROP DATABASE IF EXISTS test_auth_db;

-- CREATE DATABASE test_auth_db;

USE test_auth_db;

SHOW TABLES;

/*
===============================================================================
CREATE ROLES TABLE
===============================================================================
*/

DROP TABLE IF EXISTS roles;

CREATE TABLE roles
(
    pk_role_id      BINARY(16) PRIMARY KEY,
    role_name       VARCHAR(100)
);


/*
===============================================================================
CREATE USERS TABLE
===============================================================================
*/

DROP TABLE IF EXISTS users;

CREATE TABLE users
(
    pk_user_id             BINARY(16) PRIMARY KEY,
    fk_role_id             BINARY(16),

    username               VARCHAR(100),
    email                  VARCHAR(255),

    password_hash          VARCHAR(255),

    is_email_verified      BOOLEAN,

    is_locked              BOOLEAN,
    locked_at              TIMESTAMP NULL,

    is_active              BOOLEAN,

    is_deleted             BOOLEAN,
    deleted_at             TIMESTAMP NULL
);


/*
===============================================================================
INSERT ROLES
===============================================================================
*/

SET @admin_role_id = UUID_TO_BIN(UUID(), TRUE);
SET @user_role_id  = UUID_TO_BIN(UUID(), TRUE);

INSERT INTO roles
(
    pk_role_id,
    role_name
)
VALUES
(
    @admin_role_id,
    'ADMIN'
),
(
    @user_role_id,
    'USER'
);


/*
===============================================================================
INSERT USERS
===============================================================================
*/

/* SUCCESS USER */

INSERT INTO users
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    @admin_role_id,

    'john',
    'john@test.com',

    'hashed_password_john',

    TRUE,

    FALSE,
    NULL,

    TRUE,

    FALSE,
    NULL
);


/* INACTIVE USER */

INSERT INTO users
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    @user_role_id,

    'inactive_user',
    'inactive@test.com',

    'hashed_password_inactive',

    TRUE,

    FALSE,
    NULL,

    FALSE,

    FALSE,
    NULL
);


/* DELETED USER */

INSERT INTO users
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    @user_role_id,

    'deleted_user',
    'deleted@test.com',

    'hashed_password_deleted',

    TRUE,

    FALSE,
    NULL,

    TRUE,

    TRUE,
    NOW()
);


/* LOCKED USER */

INSERT INTO users
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    @user_role_id,

    'locked_user',
    'locked@test.com',

    'hashed_password_locked',

    TRUE,

    TRUE,
    NOW(),

    TRUE,

    FALSE,
    NULL
);


/* EMAIL NOT VERIFIED */

INSERT INTO users
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    @user_role_id,

    'unverified_user',
    'unverified@test.com',

    'hashed_password_unverified',

    FALSE,

    FALSE,
    NULL,

    TRUE,

    FALSE,
    NULL
);


/* NULL ROLE EDGE CASE */

INSERT INTO users
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    NULL,

    'null_role_user',
    'nullrole@test.com',

    'hashed_password_nullrole',

    TRUE,

    FALSE,
    NULL,

    TRUE,

    FALSE,
    NULL
);


/*
===============================================================================
CREATE PROCEDURE
===============================================================================
*/

/*
===============================================================================
Procedure   : 001_sp_get_auth_login_user
Description :
    Fetches, validates, and returns active user account information alongside 
    assigned role data for authentication routing.
Parameters  :
    IN p_login_id (VARCHAR) : The user's input email or username.
Returns     :
    A result set containing unique identifiers (UUIDs), profile information, 
    role tags, and credential strings.
Exceptions  :
    - SQLSTATE '45000' : 'User account not found'
    - SQLSTATE '45000' : 'User account inactive'
    - SQLSTATE '45000' : 'User account deleted'
    - SQLSTATE '45000' : 'User account locked'
    - SQLSTATE '45000' : 'Email address not verified'
    - SQLSTATE '45000' : 'User role assignment invalid'
    - SQLSTATE '45000' : '001_sp_get_auth_login_user failed' (Generic crash)
===============================================================================
*/

DROP PROCEDURE IF EXISTS 001_sp_get_auth_login_user;

DELIMITER $$

CREATE PROCEDURE 001_sp_get_auth_login_user
(
    IN p_login_id VARCHAR(255)
)
BEGIN

    /*
    ===========================================================================
    VARIABLES
    ===========================================================================
    */

    DECLARE v_login_id VARCHAR(255);
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

		DROP TEMPORARY TABLE IF EXISTS tmp_login_user;
		DROP TEMPORARY TABLE IF EXISTS tmp_enriched_user;
		DROP TEMPORARY TABLE IF EXISTS tmp_login_result;

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = @p1;

	END;

    /*
    ===========================================================================
    NORMALIZE INPUT
    ===========================================================================
    */

    SET v_login_id = TRIM(LOWER(p_login_id));

    /*
    ===========================================================================
    START TRANSACTION
    ===========================================================================
    */

    START TRANSACTION;

    /*
    ===========================================================================
    DROP TEMP TABLES IF EXIST
    ===========================================================================
    */

    DROP TEMPORARY TABLE IF EXISTS tmp_login_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_enriched_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_login_result;

    /*
    ===========================================================================
    CREATE TEMP TABLE
    ===========================================================================
    */

    CREATE TEMPORARY TABLE tmp_login_user
    (
        pk_user_id               BINARY(16),
        fk_role_id               BINARY(16),

        username                 VARCHAR(100),
        email                    VARCHAR(255),

        password_hash            VARCHAR(255),

        is_email_verified        BOOLEAN,

        is_locked                BOOLEAN,
        locked_at                TIMESTAMP,

        is_active                BOOLEAN,

        is_deleted               BOOLEAN,
        deleted_at               TIMESTAMP
    );

    /*
    ===========================================================================
    FETCH USER
    ===========================================================================
    */

    INSERT INTO tmp_login_user
    (
        pk_user_id,
        fk_role_id,

        username,
        email,

        password_hash,

        is_email_verified,

        is_locked,
        locked_at,

        is_active,

        is_deleted,
        deleted_at
    )
    SELECT
        u.pk_user_id,
        u.fk_role_id,

        u.username,
        u.email,

        u.password_hash,

        u.is_email_verified,

        u.is_locked,
        u.locked_at,

        u.is_active,

        u.is_deleted,
        u.deleted_at
    FROM users u
    WHERE
    (
        LOWER(u.email) = v_login_id
        OR
        LOWER(u.username) = v_login_id
    )
    LIMIT 1;

    /*
    ===========================================================================
    VALIDATE USER EXISTS
    ===========================================================================
    */

    SELECT COUNT(*)
    INTO v_row_count
    FROM tmp_login_user;

    IF v_row_count = 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User account not found';

    END IF;

    /*
    ===========================================================================
    VALIDATE ACCOUNT ACTIVE
    ===========================================================================
    */

    IF EXISTS
    (
        SELECT 1
        FROM tmp_login_user
        WHERE is_active = FALSE
    )
    THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User account inactive';

    END IF;

    /*
    ===========================================================================
    VALIDATE ACCOUNT DELETED
    ===========================================================================
    */

    IF EXISTS
    (
        SELECT 1
        FROM tmp_login_user
        WHERE is_deleted = TRUE
    )
    THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User account deleted';

    END IF;

    /*
    ===========================================================================
    VALIDATE ACCOUNT LOCKED
    ===========================================================================
    */

    IF EXISTS
    (
        SELECT 1
        FROM tmp_login_user
        WHERE is_locked = TRUE
    )
    THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User account locked';

    END IF;

    /*
    ===========================================================================
    VALIDATE EMAIL VERIFIED
    ===========================================================================
    */

    IF EXISTS
    (
        SELECT 1
        FROM tmp_login_user
        WHERE is_email_verified = FALSE
    )
    THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email address not verified';

    END IF;
    
    /*
    ===========================================================================
    DATA ENRICHMENT
    ===========================================================================
    */
    
    CREATE TEMPORARY TABLE tmp_enriched_user
    (
        pk_user_id         BINARY(16),
        fk_role_id         BINARY(16),

        username           VARCHAR(100),
        email              VARCHAR(255),
        role_name          VARCHAR(100),
        
        password_hash      VARCHAR(255)
    );
    
    INSERT INTO tmp_enriched_user
    (
        pk_user_id,
        fk_role_id,

        username,
        email,
        role_name,
        
        password_hash
    )
    WITH cte_enriched_user AS
    (
        SELECT
            u.pk_user_id,
            u.fk_role_id,

            u.username,
            u.email,
            r.role_name,
            
            u.password_hash
        FROM tmp_login_user u
        INNER JOIN roles r
            ON r.pk_role_id = u.fk_role_id
        LIMIT 1
    )
    SELECT
        pk_user_id,
        fk_role_id,
        
        username,
        email,
        role_name,
        
        password_hash
    FROM cte_enriched_user;
    
	/*
	===========================================================================
	VALIDATE ROLE ENRICHMENT
	===========================================================================
	*/

	SELECT COUNT(*)
	INTO v_row_count
	FROM tmp_enriched_user;

	IF v_row_count = 0 THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =
			'User role assignment invalid';

	END IF;
    
    /*
    ===========================================================================
    CREATE FINAL RESULT TEMP TABLE
    ===========================================================================
    */

    CREATE TEMPORARY TABLE tmp_login_result
    (
        user_id            CHAR(36),
        role_id            CHAR(36),
        
        username           VARCHAR(100),
        email              VARCHAR(255),
        role_name          VARCHAR(100),
        
        password_hash      VARCHAR(255)
    );

    /*
    ===========================================================================
    INSERT FINAL RESULT
    ===========================================================================
    */

    INSERT INTO tmp_login_result
    (
        user_id,
        role_id,
        
        username,
        email,
        role_name,
        
        password_hash
    )
    SELECT
        BIN_TO_UUID(pk_user_id, TRUE),
        BIN_TO_UUID(fk_role_id, TRUE),

        username,
        email,
        role_name,
        
        password_hash
    FROM tmp_enriched_user;
    
    /*
    ===========================================================================
    RETURN RESULT
    ===========================================================================
    */

    SELECT
        user_id,
        role_id,
        
        username,
        email,
        role_name,
        
        password_hash
    FROM tmp_login_result;

    /*
    ===========================================================================
    CLEANUP
    ===========================================================================
    */

    DROP TEMPORARY TABLE IF EXISTS tmp_login_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_enriched_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_login_result;
    
    COMMIT;

END $$

DELIMITER ;


/*
===============================================================================
TEST CASE 1
SUCCESS LOGIN USING USERNAME
===============================================================================
*/

CALL 001_sp_get_auth_login_user('john');


/*
===============================================================================
TEST CASE 2
SUCCESS LOGIN USING EMAIL
===============================================================================
*/

CALL 001_sp_get_auth_login_user('john@test.com');


/*
===============================================================================
TEST CASE 3
TRIM SPACES
===============================================================================
*/

CALL 001_sp_get_auth_login_user('   john   ');


/*
===============================================================================
TEST CASE 4
CASE INSENSITIVE LOGIN
===============================================================================
*/

CALL 001_sp_get_auth_login_user('JoHn');


/*
===============================================================================
TEST CASE 5
USER NOT FOUND
EXPECTED:
User account not found
===============================================================================
*/

CALL 001_sp_get_auth_login_user('ghost_user');


/*
===============================================================================
TEST CASE 6
INACTIVE ACCOUNT
EXPECTED:
User account inactive
===============================================================================
*/

CALL 001_sp_get_auth_login_user('inactive_user');


/*
===============================================================================
TEST CASE 7
DELETED ACCOUNT
EXPECTED:
User account deleted
===============================================================================
*/

CALL 001_sp_get_auth_login_user('deleted_user');


/*
===============================================================================
TEST CASE 8
LOCKED ACCOUNT
EXPECTED:
User account locked
===============================================================================
*/

CALL 001_sp_get_auth_login_user('locked_user');


/*
===============================================================================
TEST CASE 9
EMAIL NOT VERIFIED
EXPECTED:
Email address not verified
===============================================================================
*/

CALL 001_sp_get_auth_login_user('unverified_user');


/*
===============================================================================
TEST CASE 10
ROLE JOIN FAILURE
EXPECTED:
User role assignment invalid

Reason:
INNER JOIN returns 0 rows because fk_role_id is NULL
===============================================================================
*/

CALL 001_sp_get_auth_login_user('null_role_user');


/*
===============================================================================
TEST CASE 11
DUPLICATE USERNAME EDGE CASE
EXPECTED:
One arbitrary row because LIMIT 1 exists
===============================================================================
*/

INSERT INTO users
VALUES
(
    UUID_TO_BIN(UUID(), TRUE),
    @user_role_id,

    'john',
    'john2@test.com',

    'duplicate_password',

    TRUE,

    FALSE,
    NULL,

    TRUE,

    FALSE,
    NULL
);

CALL 001_sp_get_auth_login_user('john');

SELECT 
	*
FROM USERS;

/*
===============================================================================
TEST CASE 12
VERIFY TEMP TABLE CLEANUP
===============================================================================
*/

SHOW TABLES LIKE 'tmp_%';


/*
===============================================================================
OPTIONAL CLEANUP
===============================================================================
*/

-- DROP DATABASE test_auth_db;
/*
===============================================================================
Procedure   : 001_sp_auth_register_user
Description :
    Registers a new user account, validates role assignment, revokes previous
    email verification tokens, inserts a new verification token, and returns
    enriched registration result data.
Parameters  :
    IN p_user_id (BINARY(16))
    IN p_email_verification_token_id (BINARY(16))

    IN p_username (VARCHAR(100))
    IN p_email (VARCHAR(255))

    IN p_password_hash (VARCHAR(255))

    IN p_role_name (VARCHAR(100))

    IN p_verification_token_hash (VARCHAR(255))
    IN p_verification_token_expires_at (TIMESTAMP)
Returns     :
    Registered user enriched result set.
Exceptions  :
    - Username already exists
    - Email address already exists
    - User role not found
    - User role inactive
    - User role deleted
    - Invalid username
    - Invalid email address
    - Invalid password hash
    - Verification token invalid
    - 001_sp_auth_register_user failed
===============================================================================
*/

-- DROP PROCEDURE IF EXISTS 001_sp_auth_register_user;

-- SHOW CREATE PROCEDURE `001_sp_auth_register_user`;

-- SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DELIMITER $$

CREATE PROCEDURE 001_sp_auth_register_user
(
    IN p_user_id BINARY(16),
    IN p_email_verification_token_id BINARY(16),

    IN p_username VARCHAR(100),
    IN p_email VARCHAR(255),

    IN p_password_hash VARCHAR(255),

    IN p_role_name VARCHAR(100),

    IN p_verification_token_hash VARCHAR(255),
    IN p_verification_token_expires_at TIMESTAMP
)
BEGIN

    /*
    ===========================================================================
    VARIABLES
    ===========================================================================
    */

    DECLARE v_user_id BINARY(16);
    DECLARE v_email_verification_token_id BINARY(16);

    DECLARE v_username VARCHAR(100);
    DECLARE v_email VARCHAR(255);

    DECLARE v_password_hash VARCHAR(255);

    DECLARE v_role_name VARCHAR(100);
    DECLARE v_role_id BINARY(16);

    DECLARE v_verification_token_hash VARCHAR(255);
    DECLARE v_verification_token_expires_at TIMESTAMP;

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

        DROP TEMPORARY TABLE IF EXISTS tmp_role_lookup;
        DROP TEMPORARY TABLE IF EXISTS tmp_existing_user;
        DROP TEMPORARY TABLE IF EXISTS tmp_inserted_user;
        DROP TEMPORARY TABLE IF EXISTS tmp_register_result;

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = @p1;

    END;

    /*
    ===========================================================================
    NORMALIZE INPUT
    ===========================================================================
    */

    SET v_user_id = p_user_id;

    SET v_email_verification_token_id =
        p_email_verification_token_id;

    SET v_username =
        TRIM(LOWER(p_username));

    SET v_email =
        TRIM(LOWER(p_email));

    SET v_password_hash =
        TRIM(p_password_hash);

    SET v_role_name =
        TRIM(UPPER(p_role_name));

    SET v_verification_token_hash =
        TRIM(p_verification_token_hash);

    SET v_verification_token_expires_at =
        p_verification_token_expires_at;

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

    DROP TEMPORARY TABLE IF EXISTS tmp_role_lookup;
    DROP TEMPORARY TABLE IF EXISTS tmp_existing_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_inserted_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_enriched_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_register_result;

    /*
    ===========================================================================
    CREATE TEMP TABLES
    ===========================================================================
    */

    CREATE TEMPORARY TABLE tmp_role_lookup
    (
        pk_role_id BINARY(16),

        role_name VARCHAR(100),

        is_active BOOLEAN,
        is_deleted BOOLEAN
    );

    CREATE TEMPORARY TABLE tmp_existing_user
    (
        pk_user_id BINARY(16),

        username VARCHAR(100),
        email VARCHAR(255)
    );

    CREATE TEMPORARY TABLE tmp_inserted_user
    (
        pk_user_id BINARY(16),
        fk_role_id BINARY(16),

        username VARCHAR(100),
        email VARCHAR(255),

        is_email_verified BOOLEAN,
        is_active BOOLEAN,

        created_at TIMESTAMP
    );
    
	CREATE TEMPORARY TABLE tmp_enriched_user
    (
        user_id CHAR(36),
        role_id CHAR(36),

        username VARCHAR(100),
        email VARCHAR(255),

        role_name VARCHAR(100),

        is_email_verified BOOLEAN,
        is_active BOOLEAN,

        created_at TIMESTAMP
    );

    CREATE TEMPORARY TABLE tmp_register_result
    (
        user_id CHAR(36),
        role_id CHAR(36),

        username VARCHAR(100),
        email VARCHAR(255),

        role_name VARCHAR(100),

        is_email_verified BOOLEAN,
        is_active BOOLEAN,

        created_at TIMESTAMP
    );

    /*
    ===========================================================================
    VALIDATE INPUTS
    ===========================================================================
    */

	/*
	===========================================================================
	VALIDATE USERNAME
	===========================================================================

	Purpose :
		Ensures username input is present after normalization.
	*/

	IF v_username IS NULL
	OR v_username = '' THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Invalid username';

	END IF;

	/*
	===========================================================================
	VALIDATE EMAIL
	===========================================================================

	Purpose :
		Ensures email input is present after normalization.
	*/

	IF v_email IS NULL
	OR v_email = '' THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Invalid email address';

	END IF;

	/*
	===========================================================================
	VALIDATE PASSWORD HASH
	===========================================================================

	Purpose :
		Ensures backend-generated password hash exists.
	*/

	IF v_password_hash IS NULL
	OR v_password_hash = '' THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Invalid password hash';

	END IF;

	/*
	===========================================================================
	VALIDATE ROLE NAME
	===========================================================================

	Purpose :
		Ensures requested role name exists as input.
	*/

	IF v_role_name IS NULL
	OR v_role_name = '' THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'User role not found';

	END IF;

	/*
	===========================================================================
	VALIDATE VERIFICATION TOKEN HASH
	===========================================================================

	Purpose :
		Ensures verification token hash exists.
	*/

	IF v_verification_token_hash IS NULL
	OR v_verification_token_hash = '' THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Verification token invalid';

	END IF;

	/*
	===========================================================================
	VALIDATE VERIFICATION TOKEN EXPIRY
	===========================================================================

	Purpose :
		Ensures verification token expiry timestamp exists.
	*/

	IF v_verification_token_expires_at IS NULL THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Verification token invalid';

	END IF;

	/*
	===========================================================================
	FETCH ROLE
	===========================================================================

	Purpose :
		Fetches requested role information for validation and inserts it into
		temporary lookup table.
	*/

	INSERT INTO tmp_role_lookup
	(
		pk_role_id,

		role_name,

		is_active,
		is_deleted
	)
	SELECT
		r.pk_role_id,

		r.role_name,

		r.is_active,
		r.is_deleted
	FROM roles r
	WHERE UPPER(r.role_name) = v_role_name
	LIMIT 1;

    /*
    ===========================================================================
    VALIDATE ROLE
    ===========================================================================
    */

	/*
	===========================================================================
	VALIDATE ROLE EXISTS
	===========================================================================

	Purpose :
		Ensures requested role exists in roles table.
	*/

	SELECT COUNT(*)
	INTO v_row_count
	FROM tmp_role_lookup;

	IF v_row_count = 0 THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'User role not found';

	END IF;

	/*
	===========================================================================
	VALIDATE ROLE ACTIVE
	===========================================================================

	Purpose :
		Prevents registration using inactive roles.
	*/

	IF EXISTS
	(
		SELECT 1
		FROM tmp_role_lookup
		WHERE is_active = FALSE
	)
	THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'User role inactive';

	END IF;

	/*
	===========================================================================
	VALIDATE ROLE DELETED
	===========================================================================

	Purpose :
		Prevents registration using deleted roles.
	*/

	IF EXISTS
	(
		SELECT 1
		FROM tmp_role_lookup
		WHERE is_deleted = TRUE
	)
	THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'User role deleted';

	END IF;

	/*
	===========================================================================
	SET ROLE ID
	===========================================================================

	Purpose :
		Stores validated role UUID into variable for inserts.
	*/

	SELECT pk_role_id
	INTO v_role_id
	FROM tmp_role_lookup
	LIMIT 1;
    
	/*
	===========================================================================
	VALIDATE USERNAME UNIQUENESS
	===========================================================================

	Purpose :
		Ensures username is not already used by another account.
	*/

	/*
	===========================================================================
	FETCH EXISTING USERNAME
	===========================================================================
	*/

	INSERT INTO tmp_existing_user
	(
		pk_user_id,
		username,
		email
	)
	SELECT
		u.pk_user_id,
		u.username,
		u.email
	FROM users u
	WHERE LOWER(u.username) = v_username
	LIMIT 1;

	/*
	===========================================================================
	VALIDATE USERNAME EXISTS
	===========================================================================
	*/

	IF EXISTS
	(
		SELECT 1
		FROM tmp_existing_user
	)
	THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Username already exists';

	END IF;

	/*
	===========================================================================
	VALIDATE EMAIL UNIQUENESS
	===========================================================================

	Purpose :
		Ensures email address is not already used by another account.
	*/

	/*
	===========================================================================
	FETCH EXISTING EMAIL
	===========================================================================
	*/

	INSERT INTO tmp_existing_user
	(
		pk_user_id,
		username,
		email
	)
	SELECT
		u.pk_user_id,
		u.username,
		u.email
	FROM users u
	WHERE LOWER(u.email) = v_email
	LIMIT 1;

	/*
	===========================================================================
	VALIDATE EMAIL EXISTS
	===========================================================================
	*/

	IF EXISTS
	(
		SELECT 1
		FROM tmp_existing_user
		WHERE email = v_email
	)
	THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Email address already exists';

	END IF;

	/*
	===========================================================================
	INSERT USER
	===========================================================================

	Purpose :
		Inserts newly registered user account into users table.
	*/

	/*
	===========================================================================
	INSERT USER RECORD
	===========================================================================
	*/

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
		v_user_id,
		v_role_id,

		v_username,
		v_email,

		v_password_hash,

		FALSE,

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
	===========================================================================
	STORE INSERTED USER
	===========================================================================

	Purpose :
		Stores inserted user data into temporary table for enrichment and final
		response generation.
	*/

	INSERT INTO tmp_inserted_user
	(
		pk_user_id,
		fk_role_id,

		username,
		email,

		is_email_verified,
		is_active,

		created_at
	)
	SELECT
		u.pk_user_id,
		u.fk_role_id,

		u.username,
		u.email,

		u.is_email_verified,
		u.is_active,

		u.created_at
	FROM users u
	WHERE u.pk_user_id = v_user_id
	LIMIT 1;

	/*
	===========================================================================
	REVOKE OLD EMAIL VERIFICATION TOKENS
	===========================================================================

	Purpose :
		Revokes previously active email verification tokens before inserting
		new verification token.
	*/

	/*
	===========================================================================
	REVOKE ACTIVE TOKENS
	===========================================================================
	*/

	UPDATE email_verification_tokens
	SET
		is_active = FALSE
	WHERE fk_user_id = v_user_id
	AND is_active = TRUE;

	/*
	===========================================================================
	INSERT EMAIL VERIFICATION TOKEN
	===========================================================================

	Purpose :
		Inserts newly generated email verification token for registered user.
	*/

	/*
	===========================================================================
	INSERT EMAIL VERIFICATION TOKEN RECORD
	===========================================================================
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
		v_email_verification_token_id,
		v_user_id,

		v_verification_token_hash,

		v_verification_token_expires_at,
		NULL,

		TRUE,

		CURRENT_TIMESTAMP
	);

	/*
	===========================================================================
	ENRICH REGISTERED USER
	===========================================================================

	Purpose :
		Enriches inserted user data with role information for final response.
	*/

	/*
	===========================================================================
	CREATE ENRICHED USER CTE
	===========================================================================
	*/
    
	INSERT INTO tmp_enriched_user
	(
		user_id,
		role_id,

		username,
		email,

		role_name,

		is_email_verified,
		is_active,

		created_at
	)
	WITH cte_enriched_user AS
	(
		SELECT
			u.pk_user_id,
			u.fk_role_id,

			u.username,
			u.email,

			r.role_name,

			u.is_email_verified,
			u.is_active,

			u.created_at
		FROM tmp_inserted_user u
		INNER JOIN roles r
			ON r.pk_role_id = u.fk_role_id
	)
	SELECT
		BIN_TO_UUID(pk_user_id, TRUE),
		BIN_TO_UUID(fk_role_id, TRUE),

		username,
		email,

		role_name,

		is_email_verified,
		is_active,

		created_at
	FROM cte_enriched_user;

    /*
    ===========================================================================
    INSERT FINAL RESULT
    ===========================================================================
    */
    
	INSERT INTO tmp_register_result
	(
		user_id,
		role_id,

		username,
		email,

		role_name,

		is_email_verified,
		is_active,

		created_at
	)
	SELECT
		user_id,
		role_id,

		username,
		email,

		role_name,

		is_email_verified,
		is_active,

		created_at
	FROM tmp_enriched_user;
    
	/*
	===========================================================================
	RETURN RESULT
	===========================================================================

	Purpose :
		Returns final enriched registered user result set to backend.
	*/

	SELECT
		user_id,
		role_id,

		username,
		email,

		role_name,

		is_email_verified,
		is_active,

		created_at
	FROM tmp_register_result;

    /*
    ===========================================================================
    CLEANUP
    ===========================================================================
    */

    DROP TEMPORARY TABLE IF EXISTS tmp_role_lookup;
    DROP TEMPORARY TABLE IF EXISTS tmp_existing_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_inserted_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_enriched_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_register_result;

    COMMIT;

END $$

DELIMITER ;
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

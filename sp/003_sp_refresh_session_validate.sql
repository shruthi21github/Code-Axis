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

        ROLLBACK;

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'sp_refresh_session_validate failed';

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
        pk_user_session_id     BINARY(16),
        fk_user_id             BINARY(16),
        expires_at             TIMESTAMP,
        revoked_at             TIMESTAMP,
        is_active              BOOLEAN
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
        pk_user_session_id,
        fk_user_id,
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

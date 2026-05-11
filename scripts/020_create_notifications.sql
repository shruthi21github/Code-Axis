/*
===============================================================================
Table       : notifications
Description :
    User notification table.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Create Table
-- ============================================================================

CREATE TABLE IF NOT EXISTS notifications
(
    pk_notification_id            BINARY(16)               NOT NULL,

    fk_user_id                    BINARY(16)               NOT NULL,
    fk_notification_type_id       BINARY(16)               NOT NULL,

    title                         VARCHAR(255)             NOT NULL,
    message                       TEXT                     NOT NULL,

    is_read                       BOOLEAN                  NOT NULL DEFAULT FALSE,
    read_at                       TIMESTAMP                NULL,

    created_at                    TIMESTAMP                NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by                    BINARY(16)               NULL,

    CONSTRAINT pk_notifications
        PRIMARY KEY (pk_notification_id),

    CONSTRAINT fk_notifications_user_id
        FOREIGN KEY (fk_user_id)
        REFERENCES users(pk_user_id),

    CONSTRAINT fk_notifications_notification_type_id
        FOREIGN KEY (fk_notification_type_id)
        REFERENCES notification_types(pk_notification_type_id)
);

-- ============================================================================
-- Table Verification
-- ============================================================================

DESCRIBE notifications;

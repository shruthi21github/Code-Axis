/*
===============================================================================
Task        : Index Optimization
File        : 028_create_transaction_indexes.sql
Description :
    Index optimization for transactional and activity tables.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- project_members
-- ============================================================================

CREATE INDEX idx_project_members_project_id
ON project_members(fk_project_id);

CREATE INDEX idx_project_members_user_id
ON project_members(fk_user_id);

CREATE INDEX idx_project_members_role_id
ON project_members(fk_project_member_role_id);

CREATE INDEX idx_project_members_project_id_user_id
ON project_members(fk_project_id, fk_user_id);

-- ============================================================================
-- attendance_events
-- ============================================================================

CREATE INDEX idx_attendance_events_user_id
ON attendance_events(fk_user_id);

CREATE INDEX idx_attendance_events_event_type_id
ON attendance_events(fk_attendance_event_type_id);

CREATE INDEX idx_attendance_events_event_at
ON attendance_events(event_at);

CREATE INDEX idx_attendance_events_user_id_event_at
ON attendance_events(fk_user_id, event_at);

-- ============================================================================
-- task_status_history
-- ============================================================================

CREATE INDEX idx_task_status_history_task_id
ON task_status_history(fk_task_id);

CREATE INDEX idx_task_status_history_status_id
ON task_status_history(fk_task_status_id);

CREATE INDEX idx_task_status_history_changed_at
ON task_status_history(changed_at);

CREATE INDEX idx_task_status_history_task_id_changed_at
ON task_status_history(fk_task_id, changed_at);

-- ============================================================================
-- task_comments
-- ============================================================================

CREATE INDEX idx_task_comments_task_id
ON task_comments(fk_task_id);

CREATE INDEX idx_task_comments_user_id
ON task_comments(fk_user_id);

CREATE INDEX idx_task_comments_created_at
ON task_comments(created_at);

-- ============================================================================
-- notifications
-- ============================================================================

CREATE INDEX idx_notifications_user_id
ON notifications(fk_user_id);

CREATE INDEX idx_notifications_notification_type_id
ON notifications(fk_notification_type_id);

CREATE INDEX idx_notifications_is_read
ON notifications(is_read);

CREATE INDEX idx_notifications_user_id_is_read
ON notifications(fk_user_id, is_read);

-- ============================================================================
-- reports
-- ============================================================================

CREATE INDEX idx_reports_user_id
ON reports(fk_user_id);

CREATE INDEX idx_reports_report_type_id
ON reports(fk_report_type_id);

CREATE INDEX idx_reports_generated_at
ON reports(generated_at);

-- ============================================================================
-- attachments
-- ============================================================================

CREATE INDEX idx_attachments_user_id
ON attachments(fk_user_id);

CREATE INDEX idx_attachments_entity_type
ON attachments(entity_type);

CREATE INDEX idx_attachments_entity_id
ON attachments(entity_id);

CREATE INDEX idx_attachments_entity_type_entity_id
ON attachments(entity_type, entity_id);

CREATE INDEX idx_attachments_is_deleted
ON attachments(is_deleted);

-- ============================================================================
-- user_sessions
-- ============================================================================

CREATE INDEX idx_user_sessions_user_id
ON user_sessions(fk_user_id);

CREATE INDEX idx_user_sessions_refresh_token_expires_at
ON user_sessions(refresh_token_expires_at);

-- CREATE INDEX idx_user_sessions_is_active
-- ON user_sessions(is_active);

-- CREATE INDEX idx_user_sessions_refresh_token_hash
-- ON user_sessions(refresh_token_hash);

CREATE INDEX idx_user_sessions_refresh_lookup
ON user_sessions
(
    refresh_token_hash,
    is_active,
    revoked_at,
    refresh_token_expires_at
);

CREATE INDEX idx_user_sessions_user_id_is_active
ON user_sessions
(
    fk_user_id,
    is_active
);

SHOW INDEXES FROM user_sessions;

-- ============================================================================
-- alter
-- ============================================================================

-- DROP INDEX idx_user_sessions_expires_at
-- ON user_sessions;

-- DROP INDEX idx_user_sessions_token_hash
-- ON user_sessions;

-- DROP INDEX idx_user_sessions_refresh_token_hash
-- ON user_sessions;

-- DROP INDEX idx_user_sessions_is_active
-- ON user_sessions;

-- ============================================================================
-- password_reset_tokens
-- ============================================================================

CREATE INDEX idx_password_reset_tokens_user_id
ON password_reset_tokens(fk_user_id);

CREATE INDEX idx_password_reset_tokens_expires_at
ON password_reset_tokens(expires_at);

CREATE INDEX idx_password_reset_tokens_is_active
ON password_reset_tokens(is_active);

-- ============================================================================
-- email_verification_tokens
-- ============================================================================

CREATE INDEX idx_email_verification_tokens_user_id
ON email_verification_tokens(fk_user_id);

CREATE INDEX idx_email_verification_tokens_expires_at
ON email_verification_tokens(expires_at);

CREATE INDEX idx_email_verification_tokens_is_active
ON email_verification_tokens(is_active);

CREATE INDEX idx_email_verification_tokens_ver_tok_has_act_exp_at
ON email_verification_tokens (verification_token_hash, is_active, expires_at);



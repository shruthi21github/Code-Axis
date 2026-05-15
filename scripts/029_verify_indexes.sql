/*
===============================================================================
Task        : Index Optimization
File        : 029_verify_indexes.sql
Description :
    Verification queries for database indexes.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Show All Tables
-- ============================================================================

SHOW TABLES;

-- ============================================================================
-- Show Indexes
-- ============================================================================

SHOW INDEXES FROM roles;
SHOW INDEXES FROM users;
SHOW INDEXES FROM employees;
SHOW INDEXES FROM projects;
SHOW INDEXES FROM tasks;
SHOW INDEXES FROM project_members;
SHOW INDEXES FROM attendance_events;
SHOW INDEXES FROM task_status_history;
SHOW INDEXES FROM task_comments;
SHOW INDEXES FROM notifications;
SHOW INDEXES FROM reports;
SHOW INDEXES FROM attachments;
SHOW INDEXES FROM user_sessions;
SHOW INDEXES FROM password_reset_tokens;
SHOW INDEXES FROM email_verification_tokens;

SHOW INDEXES FROM permissions;
SHOW INDEXES FROM role_permissions;

-- ============================================================================
-- Custom show indexes
-- ============================================================================

SHOW INDEXES FROM users;
SHOW INDEXES FROM user_sessions;
SHOW INDEXES FROM email_verification_tokens;

-- ============================================================================
-- Query Execution Plan Examples
-- ============================================================================

EXPLAIN
SELECT *
FROM users
WHERE email = 'admin@codeaxis.com';

EXPLAIN
SELECT *
FROM tasks
WHERE fk_user_id = UNHEX(REPLACE(UUID(), '-', ''));

EXPLAIN
SELECT *
FROM attendance_events
WHERE fk_user_id = UNHEX(REPLACE(UUID(), '-', ''))
ORDER BY event_at DESC;

EXPLAIN
SELECT *
FROM notifications
WHERE fk_user_id = UNHEX(REPLACE(UUID(), '-', ''))
AND is_read = FALSE;
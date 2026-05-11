/*
===============================================================================
Project     : Code Axis
Description :
    Master execution order reference for database setup.
===============================================================================
*/

-- ============================================================================
-- B-15 Schema Design
-- ============================================================================

001_create_database.sql

-- ============================================================================
-- B-16 Table Creation
-- ============================================================================

002_create_roles.sql
003_create_departments.sql
004_create_designations.sql
005_create_attendance_event_types.sql
006_create_project_statuses.sql
007_create_project_member_roles.sql
008_create_task_statuses.sql
009_create_task_priorities.sql
010_create_notification_types.sql
011_create_report_types.sql

012_create_users.sql
013_create_employees.sql
014_create_projects.sql
015_create_tasks.sql

016_create_project_members.sql
017_create_attendance_events.sql
018_create_task_status_history.sql
019_create_task_comments.sql
020_create_notifications.sql
021_create_reports.sql
022_create_attachments.sql
023_create_user_sessions.sql
024_create_password_reset_tokens.sql

-- ============================================================================
-- B-17 Index Optimization
-- ============================================================================

025_create_lookup_indexes.sql
026_create_user_employee_indexes.sql
027_create_project_task_indexes.sql
028_create_transaction_indexes.sql
029_verify_indexes.sql

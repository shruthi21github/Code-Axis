/*
===============================================================================
Task        : B-17 Index Optimization
File        : 025_create_lookup_indexes.sql
Description :
    Index optimization for lookup/master tables.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- roles
-- ============================================================================

CREATE INDEX idx_roles_is_active
ON roles(is_active);

CREATE INDEX idx_roles_is_deleted
ON roles(is_deleted);

-- ============================================================================
-- departments
-- ============================================================================

CREATE INDEX idx_departments_is_active
ON departments(is_active);

CREATE INDEX idx_departments_is_deleted
ON departments(is_deleted);

-- ============================================================================
-- designations
-- ============================================================================

CREATE INDEX idx_designations_is_active
ON designations(is_active);

CREATE INDEX idx_designations_is_deleted
ON designations(is_deleted);

-- ============================================================================
-- attendance_event_types
-- ============================================================================

CREATE INDEX idx_attendance_event_types_is_active
ON attendance_event_types(is_active);

-- ============================================================================
-- project_statuses
-- ============================================================================

CREATE INDEX idx_project_statuses_is_active
ON project_statuses(is_active);

-- ============================================================================
-- project_member_roles
-- ============================================================================

CREATE INDEX idx_project_member_roles_is_active
ON project_member_roles(is_active);

-- ============================================================================
-- task_statuses
-- ============================================================================

CREATE INDEX idx_task_statuses_is_active
ON task_statuses(is_active);

-- ============================================================================
-- task_priorities
-- ============================================================================

CREATE INDEX idx_task_priorities_is_active
ON task_priorities(is_active);

-- ============================================================================
-- notification_types
-- ============================================================================

CREATE INDEX idx_notification_types_is_active
ON notification_types(is_active);

-- ============================================================================
-- report_types
-- ============================================================================

CREATE INDEX idx_report_types_is_active
ON report_types(is_active);

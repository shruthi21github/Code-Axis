/*
===============================================================================
Task        : Index Optimization
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

/*
===============================================================================
Courses Table Indexes
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- courses
-- ============================================================================

CREATE INDEX idx_courses_department_id
ON courses(fk_department_id);

CREATE INDEX idx_courses_duration_unit_id
ON courses(fk_duration_unit_id);

CREATE INDEX idx_courses_is_active
ON courses(is_active);

CREATE INDEX idx_courses_is_deleted
ON courses(is_deleted);

CREATE INDEX idx_courses_start_date
ON courses(start_date);

CREATE INDEX idx_courses_end_date
ON courses(end_date);

CREATE INDEX idx_courses_department_id_is_active
ON courses(fk_department_id, is_active);

/*
===============================================================================
duration_units Table Indexes
===============================================================================
*/

USE code_axis_db;

CREATE INDEX idx_duration_units_is_active
ON duration_units(is_active);

CREATE INDEX idx_duration_units_is_deleted
ON duration_units(is_deleted);

/*
===============================================================================
student_statuses Table Indexes
===============================================================================
*/

CREATE INDEX idx_student_statuses_is_active
ON student_statuses(is_active);

CREATE INDEX idx_student_statuses_is_deleted
ON student_statuses(is_deleted);

-- ============================================================================
-- permissions
-- ============================================================================

CREATE INDEX idx_permissions_module_name
    ON permissions (module_name);

CREATE INDEX idx_permissions_is_active
    ON permissions (is_active);

CREATE INDEX idx_permissions_is_deleted
    ON permissions (is_deleted);

-- ============================================================================
-- role_permissions
-- ============================================================================

CREATE INDEX idx_role_permissions_role_id
    ON role_permissions (fk_role_id);

CREATE INDEX idx_role_permissions_permission_id
    ON role_permissions (fk_permission_id);

CREATE INDEX idx_role_permissions_is_active
    ON role_permissions (is_active);

CREATE INDEX idx_role_permissions_is_deleted
    ON role_permissions (is_deleted);
/*
===============================================================================
Task        : Index Optimization
File        : 026_create_user_employee_indexes.sql
Description :
    Index optimization for users and employees tables.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- users
-- ============================================================================

CREATE INDEX idx_users_role_id
ON users(fk_role_id);

CREATE INDEX idx_users_is_active
ON users(is_active);

CREATE INDEX idx_users_is_deleted
ON users(is_deleted);

CREATE INDEX idx_users_is_locked
ON users(is_locked);

CREATE INDEX idx_users_last_login_at
ON users(last_login_at);

CREATE INDEX idx_users_email_is_active
ON users(email, is_active);

CREATE INDEX idx_users_username_is_active
ON users(username, is_active);

-- ============================================================================
-- employees
-- ============================================================================

CREATE INDEX idx_employees_department_id
ON employees(fk_department_id);

CREATE INDEX idx_employees_designation_id
ON employees(fk_designation_id);

CREATE INDEX idx_employees_manager_employee_id
ON employees(fk_manager_employee_id);

CREATE INDEX idx_employees_is_active
ON employees(is_active);

CREATE INDEX idx_employees_is_deleted
ON employees(is_deleted);

CREATE INDEX idx_employees_joining_date
ON employees(joining_date);

CREATE INDEX idx_employees_department_active
ON employees(fk_department_id, is_active);

CREATE INDEX idx_employees_manager_active
ON employees(fk_manager_employee_id, is_active);

/*
===============================================================================
Students Table Indexes
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- students
-- ============================================================================

CREATE INDEX idx_students_department_id
ON students(fk_department_id);

CREATE INDEX idx_students_course_id
ON students(fk_course_id);

CREATE INDEX idx_students_student_status_id
ON students(fk_student_status_id);

CREATE INDEX idx_students_employee_id
ON students(fk_employee_id);

CREATE INDEX idx_students_is_active
ON students(is_active);

CREATE INDEX idx_students_is_deleted
ON students(is_deleted);

CREATE INDEX idx_students_joining_date
ON students(joining_date);

CREATE INDEX idx_students_department_id_is_active
ON students(fk_department_id, is_active);

CREATE INDEX idx_students_course_id_is_active
ON students(fk_course_id, is_active);

CREATE INDEX idx_students_employee_id_is_active
ON students(fk_employee_id, is_active);

-- ============================================================================
-- student_status_history
-- ============================================================================

CREATE INDEX idx_student_status_history_student_id
ON student_status_history(fk_student_id);

CREATE INDEX idx_student_status_history_status_id
ON student_status_history(fk_student_status_id);

CREATE INDEX idx_student_status_history_changed_at
ON student_status_history(changed_at);

CREATE INDEX idx_student_status_history_student_id_changed_at
ON student_status_history(fk_student_id, changed_at);

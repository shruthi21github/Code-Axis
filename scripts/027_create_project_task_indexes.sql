/*
===============================================================================
Task        : B-17 Index Optimization
File        : 027_create_project_task_indexes.sql
Description :
    Index optimization for projects and tasks tables.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- projects
-- ============================================================================

CREATE INDEX idx_projects_project_status_id
ON projects(fk_project_status_id);

CREATE INDEX idx_projects_is_active
ON projects(is_active);

CREATE INDEX idx_projects_is_deleted
ON projects(is_deleted);

CREATE INDEX idx_projects_deadline_at
ON projects(deadline_at);

CREATE INDEX idx_projects_status_active
ON projects(fk_project_status_id, is_active);

CREATE INDEX idx_projects_start_deadline
ON projects(start_at, deadline_at);

-- ============================================================================
-- tasks
-- ============================================================================

CREATE INDEX idx_tasks_project_id
ON tasks(fk_project_id);

CREATE INDEX idx_tasks_employee_id
ON tasks(fk_employee_id);

CREATE INDEX idx_tasks_task_status_id
ON tasks(fk_task_status_id);

CREATE INDEX idx_tasks_task_priority_id
ON tasks(fk_task_priority_id);

CREATE INDEX idx_tasks_deadline_at
ON tasks(deadline_at);

CREATE INDEX idx_tasks_completed_at
ON tasks(completed_at);

CREATE INDEX idx_tasks_is_active
ON tasks(is_active);

CREATE INDEX idx_tasks_is_deleted
ON tasks(is_deleted);

CREATE INDEX idx_tasks_project_status
ON tasks(fk_project_id, fk_task_status_id);

CREATE INDEX idx_tasks_employee_status
ON tasks(fk_employee_id, fk_task_status_id);

CREATE INDEX idx_tasks_employee_deadline
ON tasks(fk_employee_id, deadline_at);

CREATE INDEX idx_tasks_project_priority
ON tasks(fk_project_id, fk_task_priority_id);

/*
===============================================================================
Seed Data  : permissions
Description:
    Seed RBAC permissions inventory for all system modules.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Seed Data
-- ============================================================================

INSERT INTO permissions
(
    pk_permission_id,
    module_name,
    action_name,
    permission_name,
    permission_description
)
VALUES

-- ============================================================================
-- AUTH
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000001'), 'auth', 'login', 'auth.login', 'Login permission'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000002'), 'auth', 'logout', 'auth.logout', 'Logout permission'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000003'), 'auth', 'refresh_token', 'auth.refresh_token', 'Refresh token permission'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000004'), 'auth', 'verify_email', 'auth.verify_email', 'Verify email permission'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000005'), 'auth', 'reset_password', 'auth.reset_password', 'Reset password permission'),

-- ============================================================================
-- ROLES
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000006'), 'roles', 'create', 'roles.create', 'Create roles'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000007'), 'roles', 'read', 'roles.read', 'Read roles'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000008'), 'roles', 'update', 'roles.update', 'Update roles'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000009'), 'roles', 'delete', 'roles.delete', 'Delete roles'),

-- ============================================================================
-- PERMISSIONS
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000010'), 'permissions', 'create', 'permissions.create', 'Create permissions'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000011'), 'permissions', 'read', 'permissions.read', 'Read permissions'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000012'), 'permissions', 'update', 'permissions.update', 'Update permissions'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000013'), 'permissions', 'delete', 'permissions.delete', 'Delete permissions'),

-- ============================================================================
-- ROLE PERMISSIONS
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000014'), 'role_permissions', 'create', 'role_permissions.create', 'Create role permissions'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000015'), 'role_permissions', 'read', 'role_permissions.read', 'Read role permissions'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000016'), 'role_permissions', 'update', 'role_permissions.update', 'Update role permissions'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000017'), 'role_permissions', 'delete', 'role_permissions.delete', 'Delete role permissions'),

-- ============================================================================
-- USERS
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000018'), 'users', 'create', 'users.create', 'Create users'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000019'), 'users', 'read', 'users.read', 'Read users'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000020'), 'users', 'update', 'users.update', 'Update users'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000021'), 'users', 'delete', 'users.delete', 'Delete users'),

-- ============================================================================
-- EMPLOYEES
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000022'), 'employees', 'create', 'employees.create', 'Create employees'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000023'), 'employees', 'read', 'employees.read', 'Read employees'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000024'), 'employees', 'update', 'employees.update', 'Update employees'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000025'), 'employees', 'delete', 'employees.delete', 'Delete employees'),

-- ============================================================================
-- STUDENTS
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000026'), 'students', 'create', 'students.create', 'Create students'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000027'), 'students', 'read', 'students.read', 'Read students'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000028'), 'students', 'update', 'students.update', 'Update students'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000029'), 'students', 'delete', 'students.delete', 'Delete students'),

-- ============================================================================
-- PROJECTS
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000030'), 'projects', 'create', 'projects.create', 'Create projects'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000031'), 'projects', 'read', 'projects.read', 'Read projects'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000032'), 'projects', 'update', 'projects.update', 'Update projects'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000033'), 'projects', 'delete', 'projects.delete', 'Delete projects'),

-- ============================================================================
-- TASKS
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000034'), 'tasks', 'create', 'tasks.create', 'Create tasks'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000035'), 'tasks', 'read', 'tasks.read', 'Read tasks'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000036'), 'tasks', 'update', 'tasks.update', 'Update tasks'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000037'), 'tasks', 'delete', 'tasks.delete', 'Delete tasks'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000038'), 'tasks', 'assign', 'tasks.assign', 'Assign tasks'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000039'), 'tasks', 'complete', 'tasks.complete', 'Complete tasks'),

-- ============================================================================
-- REPORTS
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000040'), 'reports', 'create', 'reports.create', 'Create reports'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000041'), 'reports', 'read', 'reports.read', 'Read reports'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000042'), 'reports', 'update', 'reports.update', 'Update reports'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000043'), 'reports', 'delete', 'reports.delete', 'Delete reports'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000044'), 'reports', 'export', 'reports.export', 'Export reports'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000045'), 'reports', 'download', 'reports.download', 'Download reports'),

-- ============================================================================
-- SYSTEM
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000046'), 'system', 'settings_update', 'system.settings_update', 'Update system settings'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000047'), 'system', 'health_check', 'system.health_check', 'System health check'),

-- ============================================================================
-- DATABASE
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000048'), 'database', 'backup', 'database.backup', 'Backup database'),
(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000049'), 'database', 'restore', 'database.restore', 'Restore database'),

-- ============================================================================
-- SEEDDATA
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000050'), 'seeddata', 'execute', 'seeddata.execute', 'Execute seed data'),

-- ============================================================================
-- MIGRATION
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000051'), 'migration', 'execute', 'migration.execute', 'Execute migrations'),

-- ============================================================================
-- INDEXES
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000052'), 'indexes', 'verify', 'indexes.verify', 'Verify indexes'),

-- ============================================================================
-- AUDIT LOGS
-- ============================================================================

(UUID_TO_BIN('0196d4d7-2000-7000-8000-000000000053'), 'audit_logs', 'read', 'audit_logs.read', 'Read audit logs');

-- ============================================================================
-- Verification
-- ============================================================================

SELECT
    *
FROM permissions
ORDER BY
    module_name,
    action_name;


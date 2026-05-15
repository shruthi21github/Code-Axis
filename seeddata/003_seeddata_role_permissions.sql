/*
===============================================================================
Seed Data  : role_permissions
Description:
    Assign permissions to RBAC roles.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- SUPER_ADMIN -> ALL PERMISSIONS
-- ============================================================================

INSERT INTO role_permissions
(
    pk_role_permission_id,
    fk_role_id,
    fk_permission_id
)
SELECT
    UUID_TO_BIN(
        CONCAT(
            '0196d4d7-3000-7000-8000-',
            LPAD(ROW_NUMBER() OVER (ORDER BY p.permission_name), 12, '0')
        )
    ),
    r.pk_role_id,
    p.pk_permission_id
FROM roles r
CROSS JOIN permissions p
WHERE r.role_name = 'SUPER_ADMIN';

-- ============================================================================
-- ADMIN
-- ============================================================================

INSERT INTO role_permissions
(
    pk_role_permission_id,
    fk_role_id,
    fk_permission_id
)
SELECT
    UUID_TO_BIN(
        CONCAT(
            '0196d4d7-3001-7000-8000-',
            LPAD(ROW_NUMBER() OVER (ORDER BY p.permission_name), 12, '0')
        )
    ),
    r.pk_role_id,
    p.pk_permission_id
FROM roles r
INNER JOIN permissions p
    ON p.module_name IN
    (
        'users',
        'employees',
        'students',
        'projects',
        'tasks',
        'reports'
    )
WHERE r.role_name = 'ADMIN';

-- ============================================================================
-- EMPLOYEE
-- ============================================================================

INSERT INTO role_permissions
(
    pk_role_permission_id,
    fk_role_id,
    fk_permission_id
)
SELECT
    UUID_TO_BIN(
        CONCAT(
            '0196d4d7-3002-7000-8000-',
            LPAD(ROW_NUMBER() OVER (ORDER BY p.permission_name), 12, '0')
        )
    ),
    r.pk_role_id,
    p.pk_permission_id
FROM roles r
INNER JOIN permissions p
    ON p.permission_name IN
    (
        'tasks.read',
        'tasks.update',
        'tasks.complete',
        'projects.read',
        'reports.read'
    )
WHERE r.role_name = 'EMPLOYEE';

-- ============================================================================
-- STUDENT
-- ============================================================================

INSERT INTO role_permissions
(
    pk_role_permission_id,
    fk_role_id,
    fk_permission_id
)
SELECT
    UUID_TO_BIN(
        CONCAT(
            '0196d4d7-3003-7000-8000-',
            LPAD(ROW_NUMBER() OVER (ORDER BY p.permission_name), 12, '0')
        )
    ),
    r.pk_role_id,
    p.pk_permission_id
FROM roles r
INNER JOIN permissions p
    ON p.permission_name IN
    (
        'tasks.read',
        'tasks.update',
        'projects.read'
    )
WHERE r.role_name = 'STUDENT';

-- ============================================================================
-- CLIENT
-- ============================================================================

INSERT INTO role_permissions
(
    pk_role_permission_id,
    fk_role_id,
    fk_permission_id
)
SELECT
    UUID_TO_BIN(
        CONCAT(
            '0196d4d7-3004-7000-8000-',
            LPAD(ROW_NUMBER() OVER (ORDER BY p.permission_name), 12, '0')
        )
    ),
    r.pk_role_id,
    p.pk_permission_id
FROM roles r
INNER JOIN permissions p
    ON p.permission_name IN
    (
        'projects.read',
        'reports.read',
        'reports.download'
    )
WHERE r.role_name = 'CLIENT';

-- ============================================================================
-- USER
-- ============================================================================

INSERT INTO role_permissions
(
    pk_role_permission_id,
    fk_role_id,
    fk_permission_id
)
SELECT
    UUID_TO_BIN(
        CONCAT(
            '0196d4d7-3005-7000-8000-',
            LPAD(ROW_NUMBER() OVER (ORDER BY p.permission_name), 12, '0')
        )
    ),
    r.pk_role_id,
    p.pk_permission_id
FROM roles r
INNER JOIN permissions p
    ON p.permission_name IN
    (
        'auth.login',
        'auth.logout',
        'auth.refresh_token',
        'auth.verify_email'
    )
WHERE r.role_name = 'USER';

-- ============================================================================
-- AUDITOR
-- ============================================================================

INSERT INTO role_permissions
(
    pk_role_permission_id,
    fk_role_id,
    fk_permission_id
)
SELECT
    UUID_TO_BIN(
        CONCAT(
            '0196d4d7-3006-7000-8000-',
            LPAD(ROW_NUMBER() OVER (ORDER BY p.permission_name), 12, '0')
        )
    ),
    r.pk_role_id,
    p.pk_permission_id
FROM roles r
INNER JOIN permissions p
    ON p.permission_name IN
    (
        'reports.read',
        'audit_logs.read',
        'indexes.verify'
    )
WHERE r.role_name = 'AUDITOR';

-- ============================================================================
-- VIEWER
-- ============================================================================

INSERT INTO role_permissions
(
    pk_role_permission_id,
    fk_role_id,
    fk_permission_id
)
SELECT
    UUID_TO_BIN(
        CONCAT(
            '0196d4d7-3007-7000-8000-',
            LPAD(ROW_NUMBER() OVER (ORDER BY p.permission_name), 12, '0')
        )
    ),
    r.pk_role_id,
    p.pk_permission_id
FROM roles r
INNER JOIN permissions p
    ON p.permission_name IN
    (
        'projects.read',
        'tasks.read',
        'reports.read'
    )
WHERE r.role_name = 'VIEWER';

-- ============================================================================
-- REPORT_ANALYST
-- ============================================================================

INSERT INTO role_permissions
(
    pk_role_permission_id,
    fk_role_id,
    fk_permission_id
)
SELECT
    UUID_TO_BIN(
        CONCAT(
            '0196d4d7-3008-7000-8000-',
            LPAD(ROW_NUMBER() OVER (ORDER BY p.permission_name), 12, '0')
        )
    ),
    r.pk_role_id,
    p.pk_permission_id
FROM roles r
INNER JOIN permissions p
    ON p.permission_name IN
    (
        'reports.read',
        'reports.export',
        'reports.download'
    )
WHERE r.role_name = 'REPORT_ANALYST';

-- ============================================================================
-- SYSTEM
-- ============================================================================

INSERT INTO role_permissions
(
    pk_role_permission_id,
    fk_role_id,
    fk_permission_id
)
SELECT
    UUID_TO_BIN(
        CONCAT(
            '0196d4d7-3009-7000-8000-',
            LPAD(ROW_NUMBER() OVER (ORDER BY p.permission_name), 12, '0')
        )
    ),
    r.pk_role_id,
    p.pk_permission_id
FROM roles r
INNER JOIN permissions p
    ON p.permission_name IN
    (
        'system.health_check',
        'auth.refresh_token'
    )
WHERE r.role_name = 'SYSTEM';

-- ============================================================================
-- SERVICE_ACCOUNT
-- ============================================================================

INSERT INTO role_permissions
(
    pk_role_permission_id,
    fk_role_id,
    fk_permission_id
)
SELECT
    UUID_TO_BIN(
        CONCAT(
            '0196d4d7-3010-7000-8000-',
            LPAD(ROW_NUMBER() OVER (ORDER BY p.permission_name), 12, '0')
        )
    ),
    r.pk_role_id,
    p.pk_permission_id
FROM roles r
INNER JOIN permissions p
    ON p.permission_name IN
    (
        'reports.export',
        'projects.read',
        'tasks.read'
    )
WHERE r.role_name = 'SERVICE_ACCOUNT';

-- ============================================================================
-- API_CLIENT
-- ============================================================================

INSERT INTO role_permissions
(
    pk_role_permission_id,
    fk_role_id,
    fk_permission_id
)
SELECT
    UUID_TO_BIN(
        CONCAT(
            '0196d4d7-3011-7000-8000-',
            LPAD(ROW_NUMBER() OVER (ORDER BY p.permission_name), 12, '0')
        )
    ),
    r.pk_role_id,
    p.pk_permission_id
FROM roles r
INNER JOIN permissions p
    ON p.permission_name IN
    (
        'projects.read',
        'tasks.read',
        'reports.read'
    )
WHERE r.role_name = 'API_CLIENT';

-- ============================================================================
-- Verification
-- ============================================================================

SELECT
    BIN_TO_UUID(rp.pk_role_permission_id) AS pk_role_permission_id,
    r.role_name,
    p.permission_name
FROM role_permissions rp
INNER JOIN roles r
    ON rp.fk_role_id = r.pk_role_id
INNER JOIN permissions p
    ON rp.fk_permission_id = p.pk_permission_id
ORDER BY
    r.role_name,
    p.permission_name;
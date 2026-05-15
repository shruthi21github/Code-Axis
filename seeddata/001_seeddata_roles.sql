/*
===============================================================================
Seed Data  : roles
Description:
    Seed default system, business, and reporting roles.
===============================================================================
*/

USE code_axis_db;

-- ============================================================================
-- Seed Data
-- ============================================================================

INSERT INTO roles
(
    pk_role_id,
    role_name,
    role_description,
    role_level
)
VALUES
(
    UUID_TO_BIN('0196d4d7-1000-7000-8000-000000000001'),
    'SUPER_ADMIN',
    'Full unrestricted system owner',
    100
),
(
    UUID_TO_BIN('0196d4d7-1000-7000-8000-000000000002'),
    'ADMIN',
    'Operational business administrator',
    90
),
(
    UUID_TO_BIN('0196d4d7-1000-7000-8000-000000000003'),
    'SYSTEM',
    'Internal system role',
    95
),
(
    UUID_TO_BIN('0196d4d7-1000-7000-8000-000000000004'),
    'SERVICE_ACCOUNT',
    'Background service account role',
    70
),
(
    UUID_TO_BIN('0196d4d7-1000-7000-8000-000000000005'),
    'API_CLIENT',
    'External API integration role',
    60
),
(
    UUID_TO_BIN('0196d4d7-1000-7000-8000-000000000006'),
    'EMPLOYEE',
    'Employee role',
    50
),
(
    UUID_TO_BIN('0196d4d7-1000-7000-8000-000000000007'),
    'STUDENT',
    'Student role',
    40
),
(
    UUID_TO_BIN('0196d4d7-1000-7000-8000-000000000008'),
    'CLIENT',
    'Client role',
    30
),
(
    UUID_TO_BIN('0196d4d7-1000-7000-8000-000000000009'),
    'REPORT_ANALYST',
    'Reporting and analytics role',
    25
),
(
    UUID_TO_BIN('0196d4d7-1000-7000-8000-000000000010'),
    'AUDITOR',
    'Read-only audit role',
    20
),
(
    UUID_TO_BIN('0196d4d7-1000-7000-8000-000000000011'),
    'VIEWER',
    'Read-only viewer role',
    15
),
(
    UUID_TO_BIN('0196d4d7-1000-7000-8000-000000000012'),
    'USER',
    'Default authenticated application user',
    10
);

-- ============================================================================
-- Verification
-- ============================================================================

SELECT
	*
FROM roles
ORDER BY role_level DESC;
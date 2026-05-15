# Seed Data Plan

## roles
Purpose:
    System authorization roles.

Mandatory:
    Yes

Rows:
    ADMIN
    EMPLOYEE
    CLIENT
    USER
    STUDENT

Script:
    001_seeddata_roles.sql
	
---------------------------------------------

# Seed Data Plan Of Action

## Project

code_axis_db

---

# 1. Seed Data Philosophy

Purpose:
Seed data should contain only mandatory static/master/system data required for the application to function correctly.

Seed data must:
- be deterministic
- be repeatable
- avoid transactional/runtime records

Seed data must NOT contain:
- user activity
- notifications
- reports
- comments
- sessions
- tokens
- runtime logs

---

# 2. Folder Structure

```text
database/
│
├── schema/
│   ├── 001_create_roles.sql
│   ├── 002_create_users.sql
│   └── ...
│
├── seeddata/
│   ├── 001_seeddata_roles.sql
│   ├── 002_seeddata_permissions.sql
│   ├── 003_seeddata_role_permissions.sql
│   └── ...
│
└── docs/
    └── seeddata-plan-of-action.md
```

---

# 3. RBAC Strategy

RBAC:
Enabled

Meaning:
Role Based Access Control

Authorization Enforcement Layer:
Java Spring Boot backend only

Database-Level Authorization:
Not enforced

Reason:
Simpler architecture
Centralized authorization logic
Easier maintenance

---

# 4. User Role Strategy

One Role Per User:
Enabled

Implementation:
users.fk_role_id

No user_roles mapping table required.

Reason:
Simpler joins
Simpler backend authorization
Simpler data model

---

# 5. Default Registration Role

Default Role:
USER

Behavior:
Every newly registered account automatically receives USER role.

---

# 6. Permission Strategy

Permission Scope:
Global system permissions only

Tenant-specific permissions:
Not supported currently

Permission Naming Convention:
lowercase dot notation

Examples:
user.create
user.read
user.update
user.delete

```
task.assign
task.complete
```

---

# 7. Permission Organization

Permissions grouped by module.

Examples:

```text
auth.login
auth.logout

user.create
user.read
user.update
user.delete

project.create
project.read
project.update
project.delete

task.create
task.read
task.update
task.delete
task.assign
task.complete
```

---

# 8. Permission Action Convention

Standard CRUD actions:
create
read
update
delete

Additional business actions allowed:
assign
complete
export
checkin
checkout

---

# 9. ADMIN Role Strategy

ADMIN role receives:
all permissions

Implementation:
seed all permissions into role_permissions for ADMIN role.

---

# 10. Soft Delete Rules

Soft-deleted roles and permissions:
must NOT be assignable or usable

Enforcement:
Java Spring Boot backend validation

---

# 11. Required RBAC Tables

## permissions

Purpose:
Master list of all system permissions.

Examples:
user.create
user.update
task.assign

Requires Seed Data:
YES

---

## role_permissions

Purpose:
Maps roles to permissions.

Requires Seed Data:
YES

---

# 12. Tables Requiring Seed Data

## roles

Purpose:
Application roles.

Requires Seed Data:
YES

Rows:
ADMIN
EMPLOYEE
CLIENT
USER
STUDENT

Script:
001_seeddata_roles.sql

---

## permissions

Purpose:
System permissions.

Requires Seed Data:
YES

Examples:
auth.login
user.create
task.assign

Script:
002_seeddata_permissions.sql

---

## role_permissions

Purpose:
Maps permissions to roles.

Requires Seed Data:
YES

Rules:
ADMIN receives all permissions.

Script:
003_seeddata_role_permissions.sql

---

## departments

Purpose:
Organization departments.

Requires Seed Data:
YES

Examples:
HR
IT
Finance

Script:
004_seeddata_departments.sql

---

## designations

Purpose:
Employee designations.

Requires Seed Data:
YES

Examples:
Manager
Developer
Trainer

Script:
005_seeddata_designations.sql

---

## duration_units

Purpose:
Course duration units.

Requires Seed Data:
YES

Examples:
DAY
WEEK
MONTH
YEAR

Script:
006_seeddata_duration_units.sql

---

## student_statuses

Purpose:
Student lifecycle states.

Requires Seed Data:
YES

Examples:
ACTIVE
COMPLETED
DROPPED
SUSPENDED

Script:
007_seeddata_student_statuses.sql

---

## project_statuses

Purpose:
Project lifecycle states.

Requires Seed Data:
YES

Examples:
PLANNED
ACTIVE
ON_HOLD
COMPLETED

Script:
008_seeddata_project_statuses.sql

---

## task_priorities

Purpose:
Task priority levels.

Requires Seed Data:
YES

Examples:
LOW
MEDIUM
HIGH
CRITICAL

Script:
009_seeddata_task_priorities.sql

---

## task_statuses

Purpose:
Task workflow states.

Requires Seed Data:
YES

Examples:
TODO
IN_PROGRESS
REVIEW
COMPLETED

Script:
010_seeddata_task_statuses.sql

---

## notification_types

Purpose:
Notification classification.

Requires Seed Data:
YES

Examples:
SYSTEM
TASK
ATTENDANCE
PROJECT

Script:
011_seeddata_notification_types.sql

---

## report_types

Purpose:
Report classification.

Requires Seed Data:
YES

Examples:
ATTENDANCE
STUDENT
PROJECT

Script:
012_seeddata_report_types.sql

---

## project_member_roles

Purpose:
Project-level member roles.

Requires Seed Data:
YES

Examples:
OWNER
MANAGER
CONTRIBUTOR

Script:
013_seeddata_project_member_roles.sql

---

## attendance_event_types

Purpose:
Attendance event tracking.

Requires Seed Data:
YES

Examples:
CHECK_IN
CHECK_OUT

Script:
014_seeddata_attendance_event_types.sql

---

# 13. Tables That Must NOT Be Seeded

## Runtime / Transactional Tables

Do NOT seed:

```text
notifications
reports
password_reset_tokens
task_comments
task_status_history
students
employees
project_members
attendance_events
user_sessions
refresh_tokens
email_verification_tokens
```

Reason:
These are generated dynamically during application usage.

---

# 14. Recommended Seed Execution Order

```text
1. roles
2. permissions
3. role_permissions

4. departments
5. designations
6. duration_units

7. student_statuses
8. project_statuses
9. task_priorities
10. task_statuses

11. notification_types
12. report_types
13. project_member_roles
14. attendance_event_types
```

Reason:
Foreign-key-safe execution order.

---

# 15. UUID Strategy

UUID generation:
UUID_TO_BIN(UUID())

UUID display:
BIN_TO_UUID(pk_column)

---

# 16. Seed Script Rules

Rules:
- Use INSERT INTO
- Avoid runtime logic
- Keep scripts idempotent later if needed
- One table per seed file
- Add verification SELECT at end

---

# 17. Future Recommendations

Possible future additions:
- default admin bootstrap user
- permission caching
- permission groups
- feature flags
- audit permissions
- API-level authorization annotations
- menu-level permissions

Current Recommendation:
Keep RBAC simple initially.

```
```

-------------------------------------------

those new tables got created and the plan of action doc is at

C:\Users\ADMIN\Downloads\mysql\code_axis_db\docs\006_RBAC_table_creation_plan.md

------

now 

files creation powershell

"C:\Users\ADMIN\Downloads\mysql\code_axis_db\seeddata"

ni "C:\Users\ADMIN\Downloads\mysql\code_axis_db\seeddata\001_seeddata_roles.sql"
ni "C:\Users\ADMIN\Downloads\mysql\code_axis_db\seeddata\002_seeddata_permissions.sql"
ni "C:\Users\ADMIN\Downloads\mysql\code_axis_db\seeddata\003_seeddata_role_permissions.sql"




--------------

# RBAC Seed Data Decisions - Roles Phase

# Purpose

Document finalized implementation decisions made during:

```text
001_seeddata_roles.sql
```

implementation phase.

This document extends:

```text
007_seeddata_plan_of_action.md
```

and captures operational RBAC seed decisions.

---

# 1. UUID Strategy

## Final Decision

Use:

* UUID v7 compatible values

inside seed scripts.

Do NOT use:

```sql
UUID()
```

Reason:

* backend uses UUID v7 generation
* maintain UUID consistency across:

  * Spring Boot
  * Hibernate
  * seed data

---

# 2. Seed UUID Strategy

## Final Decision

Use:

* hardcoded deterministic UUID v7 values

inside seed scripts.

Reason:

* repeatable deployments
* deterministic FK mapping
* stable environments
* backend consistency

---

# 3. Seeded Role Types

RBAC supports:

* business roles
* technical/system roles
* reporting/read-only roles

---

# 4. Business Roles

Seed immediately:

```text
SUPER_ADMIN
ADMIN
EMPLOYEE
STUDENT
CLIENT
USER
```

---

# 5. Technical/System Roles

Seed immediately:

```text
SYSTEM
SERVICE_ACCOUNT
API_CLIENT
```

Purpose:

* internal automation
* integrations
* background jobs
* API access

---

# 6. Reporting / Read-Only Roles

Seed immediately:

```text
AUDITOR
VIEWER
REPORT_ANALYST
```

Purpose:

* reporting access
* analytics
* read-only operations
* audit visibility

---

# 7. Role Hierarchy

Hierarchy concept:
ENABLED

Authorization remains:

* permission-based

Hierarchy provides:

* authority ordering
* management rules
* future escalation logic

---

# 8. Role Hierarchy Storage

Hierarchy stored explicitly in database.

Implementation:

```text
roles.role_level
```

---

# 9. Hierarchy Rule

Rule:

```text
higher number = higher authority
```

Example:

| Role            | Level |
| --------------- | ----- |
| SUPER_ADMIN     | 100   |
| SYSTEM          | 95    |
| ADMIN           | 90    |
| SERVICE_ACCOUNT | 70    |
| API_CLIENT      | 60    |
| EMPLOYEE        | 50    |
| STUDENT         | 40    |
| CLIENT          | 30    |
| REPORT_ANALYST  | 25    |
| AUDITOR         | 20    |
| VIEWER          | 15    |
| USER            | 10    |

---

# 10. SUPER_ADMIN Strategy

SUPER_ADMIN:

* unrestricted system ownership

SUPER_ADMIN receives:

* full unrestricted permissions

---

# 11. ADMIN Strategy

ADMIN:

* operational/business administration role

ADMIN does NOT automatically receive:

* unrestricted system ownership

Difference:

| Role        | Responsibility                  |
| ----------- | ------------------------------- |
| SUPER_ADMIN | unrestricted platform ownership |
| ADMIN       | operational administration      |

---

# 12. Role Level Constraint Decision

Do NOT enforce:

```text
UNIQUE(role_level)
```

Reason:

* multiple roles may share same authority level later

---

# 13. Role Table Redesign

Existing table redesigned:

```text
roles
```

Added column:

```sql
role_level INT NOT NULL
```

No additional foreign keys required.

---

# 14. Current RBAC Schema Status

Completed:

* roles redesign
* permissions table
* role_permissions table
* RBAC indexes
* role seed data

Current phase:

```text
permissions seed inventory design
```

------------

# RBAC Seed Data Decisions - Permissions Inventory Phase

# Purpose

Document finalized implementation decisions made during:

```text id="v2m7pk"
002_seeddata_permissions.sql
```

design phase.

This document extends:

* `007_seeddata_plan_of_action.md`
* RBAC schema design decisions
* roles seed phase decisions

---

# 1. Permission Inventory Scope

RBAC permissions generated for:

```text id="x4q8wa"
ALL current schema tables/modules
```

Including:

* business tables
* lookup tables
* audit/history tables
* internal/security tables
* RBAC tables
* token/session tables

---

# 2. Full CRUD Baseline

Every module receives default CRUD permissions.

Default actions:

```text id="k8v1mx"
create
read
update
delete
```

Examples:

```text id="g5q2pk"
students.create
students.read
students.update
students.delete
```

```text id="r7m4wa"
tasks.create
tasks.read
tasks.update
tasks.delete
```

---

# 3. Special Business Permissions

Additional business permissions generated only where logically required.

Examples:

```text id="x1v8pk"
tasks.assign
tasks.complete

reports.export
reports.download

attendance_events.checkin
attendance_events.checkout
```

Reason:

* avoid meaningless/generated actions for every table

---

# 4. Authentication Permissions

Authentication-related permissions included.

Examples:

```text id="z6q2wa"
auth.login
auth.logout
auth.refresh_token
auth.verify_email
auth.reset_password
```

---

# 5. Attachment/File Permissions

Attachments/files receive independent permissions.

Examples:

```text id="q4m7pk"
attachments.create
attachments.read
attachments.update
attachments.delete
```

---

# 6. Reporting Permissions

Reporting/export actions separated from CRUD.

Examples:

```text id="n8v1wa"
reports.read
reports.export
reports.download
```

---

# 7. Audit / History Permissions

Audit/history modules also protected through RBAC.

Examples:

```text id="f3q8pk"
task_status_history.read
student_status_history.read
audit_logs.read
```

---

# 8. Module Naming Strategy

Permission module names closely follow actual database table names.

Examples:

```text id="m7v2wa"
student_statuses.read
project_members.create
task_comments.delete
```

Reason:

* consistency with schema naming

---

# 9. Lookup/Internal Tables

Lookup/internal/master tables also receive RBAC permissions.

Examples:

```text id="v5q1pk"
duration_units.create
notification_types.update
task_priorities.delete
```

---

# 10. Security / Token / Session Tables

Internal security/session/token tables also receive permissions.

Examples:

```text id="w2m8wa"
user_sessions.read
password_reset_tokens.read
email_verification_tokens.delete
```

---

# 11. Soft Delete Permission Strategy

Soft delete uses standard delete permission.

No separate permissions for:

```text id="j9v4pk"
restore
soft_delete
```

Reason:

* keep RBAC simpler

---

# 12. Read-Only / Reporting Roles

System supports read-oriented roles.

Examples:

```text id="q6m2wa"
AUDITOR
VIEWER
REPORT_ANALYST
```

Permission model intentionally separates:

```text id="h8q1pk"
read
export
download
```

for future reporting/security flexibility.

---

# 13. RBAC Self-Protection

RBAC tables themselves protected by RBAC permissions.

Examples:

```text id="r4v7mx"
roles.create
permissions.update
role_permissions.delete
```

---

# 14. System Administration Permissions

Administrative/system maintenance permissions included.

Examples:

```text id="x3m8wa"
database.backup
database.restore
system.settings_update
```

---

# 15. Verification / Audit / Health Permissions

Verification and health-check permissions included.

Examples:

```text id="c7q2pk"
indexes.verify
audit_logs.read
system.health_check
```

---

# 16. Seed / Migration Permissions

Seed and migration execution permissions included.

Examples:

```text id="m1v8wa"
seeddata.execute
migration.execute
```

---

# 17. Final Permission Inventory Philosophy

RBAC inventory designed to support:

* backend authorization
* admin panel permissions
* reporting restrictions
* system maintenance operations
* future auditing
* internal automation
* API integrations
* technical/system accounts

---

# 18. Current RBAC Status

Completed:

* roles redesign
* permissions table
* role_permissions table
* RBAC indexes
* roles seed data
* permission inventory design

Next phase:

```text id="w5q2pk"
002_seeddata_permissions.sql
```

---------------------
# RBAC Seed Data Decisions - Role Permission Assignment Phase

# Purpose

Document finalized implementation decisions made during:

```text id="v3m8pk"
003_seeddata_role_permissions.sql
```

implementation phase.

This document extends:

* `007_seeddata_plan_of_action.md`
* RBAC schema decisions
* roles seed decisions
* permissions inventory decisions

---

# 1. SUPER_ADMIN Permission Strategy

Final Decision:

```text id="r7q2wa"
SUPER_ADMIN receives ALL permissions automatically.
```

Implementation approach:

```sql id="k4v1mx"
INSERT INTO role_permissions
SELECT ...
FROM roles
CROSS JOIN permissions
```

Reason:

* unrestricted system ownership
* centralized superuser authority
* automatic future permission inheritance

---

# 2. Automatic Permission Inheritance

When new permissions are added later:

```text id="f8m2pk"
SUPER_ADMIN should automatically receive them
```

through:

* reseeding
* migration scripts
* synchronization logic later

Reason:

* avoid manual permission maintenance

---

# 3. Role Permission Seeding Scope

Current implementation seeds only:

```text id="y5q7wa"
SUPER_ADMIN
```

Reason:

* safest initial RBAC bootstrap strategy
* avoids premature restriction design
* permission matrices for other roles can evolve later

---

# 4. Other Roles Strategy

Roles currently NOT auto-seeded with permissions:

```text id="u2v8pk"
ADMIN
EMPLOYEE
STUDENT
CLIENT
USER
AUDITOR
VIEWER
REPORT_ANALYST
SYSTEM
SERVICE_ACCOUNT
API_CLIENT
```

Reason:

* business authorization rules still evolving
* prevents accidental over-permissioning

---

# 5. ADMIN Role Strategy

ADMIN intentionally does NOT receive:

```text id="p6m1wa"
all permissions
```

Difference:

| Role        | Access Scope               |
| ----------- | -------------------------- |
| SUPER_ADMIN | unrestricted               |
| ADMIN       | operational/business admin |

---

# 6. UUID Strategy

Current implementation uses:

```sql id="n8q4pk"
UUID_TO_BIN(UUID())
```

for:

* role_permissions mapping rows only

Reason:

* mapping rows are system-generated bridge records
* deterministic IDs not critical here

Master/static entities continue using:

* hardcoded UUID v7 values

Examples:

* roles
* permissions

---

# 7. RBAC Initialization Philosophy

Initialization approach:

```text id="x4v7mx"
minimal secure bootstrap
```

Meaning:

* only SUPER_ADMIN receives full access initially
* additional role permission matrices designed later intentionally

---

# 8. Current RBAC Status

Completed:

* RBAC schema
* roles redesign
* permissions table
* role_permissions table
* RBAC indexes
* roles seed data
* permissions inventory seed data
* SUPER_ADMIN permission assignment

Current RBAC system now operational.

---------------

# RBAC Role Permission Matrix Design

# Purpose

Define practical initial permission assignments for seeded roles in:

```text id="g4m8pk"
code_axis_db
```

This phase extends:

* RBAC schema
* permissions inventory
* SUPER_ADMIN bootstrap initialization

---

# 1. Authorization Philosophy

RBAC remains:

```text id="q7v2wa"
permission-based
```

Role hierarchy assists:

* authority ordering
* management logic

but authorization checks remain permission-driven.

---

# 2. SUPER_ADMIN Strategy

SUPER_ADMIN receives:

```text id="x3m7pk"
ALL permissions
```

Purpose:

* unrestricted system ownership
* disaster recovery
* platform administration

---

# 3. ADMIN Strategy

ADMIN receives:

* operational/business administration permissions

ADMIN does NOT receive:

* low-level infrastructure permissions
* migration permissions
* database restore permissions

Allowed examples:

```text id="m9q2wa"
users.*
employees.*
students.*
projects.*
tasks.*
reports.*
```

Restricted examples:

```text id="r5v8pk"
database.restore
migration.execute
seeddata.execute
```

---

# 4. EMPLOYEE Strategy

EMPLOYEE role represents:

* internal staff users

Allowed examples:

```text id="j1m4wa"
tasks.read
tasks.update
tasks.complete

projects.read

attendance_events.checkin
attendance_events.checkout

reports.read
```

Restricted:

* user management
* RBAC management
* database operations

---

# 5. STUDENT Strategy

STUDENT role represents:

* enrolled learners/interns

Allowed examples:

```text id="n7q2pk"
tasks.read
tasks.update

projects.read

attendance_events.checkin
attendance_events.checkout
```

Restricted:

* employee management
* RBAC management
* report administration

---

# 6. CLIENT Strategy

CLIENT role represents:

* external business/customer users

Allowed examples:

```text id="y4m8wa"
projects.read
reports.read
reports.download
```

Restricted:

* internal operational systems
* RBAC systems
* employee/student management

---

# 7. USER Strategy

USER role represents:

* generic authenticated application account

Allowed examples:

```text id="p6q1pk"
auth.login
auth.logout
auth.refresh_token
auth.verify_email
```

Purpose:

* baseline authenticated access

---

# 8. AUDITOR Strategy

AUDITOR role represents:

* compliance/audit users

Allowed examples:

```text id="f3v7mx"
reports.read
audit_logs.read
indexes.verify
```

Strictly read-only.

No:

* create
* update
* delete

---

# 9. VIEWER Strategy

VIEWER role represents:

* general read-only users

Allowed examples:

```text id="u8m2wa"
projects.read
tasks.read
reports.read
```

No modification permissions.

---

# 10. REPORT_ANALYST Strategy

REPORT_ANALYST role represents:

* analytics/reporting users

Allowed examples:

```text id="z5q8pk"
reports.read
reports.export
reports.download
```

Restricted:

* operational CRUD activities

---

# 11. SYSTEM Strategy

SYSTEM role represents:

* internal application/system automation

Allowed examples:

```text id="d1v4wa"
system.health_check
auth.refresh_token
user_sessions.read
```

Purpose:

* internal framework operations

---

# 12. SERVICE_ACCOUNT Strategy

SERVICE_ACCOUNT role represents:

* integrations/background jobs

Allowed examples:

```text id="m7q2pk"
reports.export
projects.read
tasks.read
```

Purpose:

* automation
* scheduled jobs
* integrations

---

# 13. API_CLIENT Strategy

API_CLIENT role represents:

* external API consumers

Allowed examples:

```text id="x4m8wa"
projects.read
tasks.read
reports.read
```

Restricted through:

* API gateway
* token scopes later

---

# 14. Security Philosophy

Default rule:

```text id="t8q1pk"
least privilege
```

Meaning:

* roles receive only required permissions
* unrestricted access reserved for SUPER_ADMIN

---

# 15. Current RBAC Status

Completed:

* RBAC schema
* role hierarchy
* permissions inventory
* role seed data
* permission seed data
* SUPER_ADMIN bootstrap assignment
* role permission matrix design

Next phase:

```text id="w3v7mx"
expanded role_permissions seed assignments
```

--------------

Yes. Successfully completed. 

Your RBAC system is now fully operational with:

* UUID v7-compatible IDs everywhere
* role hierarchy
* permissions inventory
* role permission mappings
* lookup indexes
* seed data
* SUPER_ADMIN bootstrap
* business/reporting/system roles

Current completed seed flow:

```text id="m7q2wa"
001_seeddata_roles.sql
002_seeddata_permissions.sql
003_seeddata_role_permissions.sql
```

Current completed schema flow:

```text id="v4m8pk"
roles
permissions
role_permissions
```

No pending RBAC tables.
No pending RBAC redesign.
No pending RBAC seed scripts.

Your next real phase is now application/backend integration:

```text id="r8v1qx"
Spring Security + JWT + permission enforcement
```

inside your Java Spring Boot backend.

------------------


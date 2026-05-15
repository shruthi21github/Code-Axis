additional permissions table

# Code Axis - RBAC Database Design Plan

# Purpose

Introduce a scalable Role Based Access Control (RBAC) architecture into:

* `code_axis_db`

This design integrates with the existing architecture while remaining consistent with:

* naming conventions
* audit columns
* soft delete strategy
* indexing strategy
* UUID strategy

---

# Finalized RBAC Architecture

## Authorization Model

```text
roles
    ↓
users.fk_role_id

roles
    ↓
role_permissions
    ↓
permissions
```

---

# Core RBAC Decisions

## RBAC Enabled

Role Based Access Control:
ENABLED

---

## Role Assignment Strategy

One user:
one role only

Implementation:

```text
users.fk_role_id
```

No:
user_roles

mapping table required.

---

## Permission Naming Convention

Lowercase dot notation.

Examples:

```text
user.create
user.read
user.update
user.delete

task.assign
task.complete

project.create
report.export
```

---

## Permission Organization

Permissions grouped by module.

Examples:

| module_name | permission_name |
| ----------- | --------------- |
| user        | user.create     |
| task        | task.assign     |
| report      | report.export   |

---

## Permission Action Convention

Standard CRUD supported:

* create
* read
* update
* delete

Additional business actions supported:

* assign
* complete
* export
* checkin
* checkout

---

## Authorization Enforcement Layer

Authorization enforced in:

* Java Spring Boot backend

Database authorization:
NOT enforced

No:

* triggers
* heavy DB-side RBAC validation

---

## Soft Delete Strategy

Soft delete enabled across RBAC tables.

When:

* role soft deleted
* permission soft deleted

Then:

* related role_permissions rows also soft deleted

Implementation:

* Spring Boot service layer

Database:

* no ON DELETE CASCADE

---

# New Tables To Create

---

# 036_create_permissions.sql

## Purpose

Master table storing all system permissions.

Examples:

```text
user.create
user.update
task.assign
report.export
attendance.checkin
```

---

# Columns

| Column Name            | Data Type    |
| ---------------------- | ------------ |
| pk_permission_id       | BINARY(16)   |
| module_name            | VARCHAR(100) |
| action_name            | VARCHAR(100) |
| permission_name        | VARCHAR(150) |
| permission_description | VARCHAR(255) |
| is_active              | BOOLEAN      |
| is_deleted             | BOOLEAN      |
| deleted_at             | TIMESTAMP    |
| created_at             | TIMESTAMP    |
| created_by             | BINARY(16)   |
| updated_at             | TIMESTAMP    |
| updated_by             | BINARY(16)   |

---

# Constraints

## PRIMARY KEY

```text
pk_permissions
    (pk_permission_id)
```

---

## UNIQUE CONSTRAINTS

### Permission Name

```text
uq_permissions_permission_name
    (permission_name)
```

Meaning:

* permission names cannot repeat globally

---

### Module + Action Combination

```text
uq_permissions_module_name_action_name
    (module_name, action_name)
```

Meaning:

* same module/action combination cannot repeat

---

# Indexes

## Module

```text
idx_permissions_module_name
    (module_name)
```

---

## Active Status

```text
idx_permissions_is_active
    (is_active)
```

---

## Deleted Status

```text
idx_permissions_is_deleted
    (is_deleted)
```

---

# Audit Strategy

Audit columns:

```text
created_by
updated_by
```

remain:

* non-FK audit fields

Reason:

* consistency with existing schema architecture

---

# Example Permissions

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

attendance.checkin
attendance.checkout

report.export
```

---

# 037_create_role_permissions.sql

## Purpose

Maps roles to permissions.

Examples:

```text
ADMIN
    → user.create
    → user.delete
    → task.assign

EMPLOYEE
    → task.read
    → attendance.checkin
```

---

# Relationships

## Role Relationship

```text
fk_role_id
    → roles.pk_role_id
```

---

## Permission Relationship

```text
fk_permission_id
    → permissions.pk_permission_id
```

---

# Columns

| Column Name           | Data Type  |
| --------------------- | ---------- |
| pk_role_permission_id | BINARY(16) |
| fk_role_id            | BINARY(16) |
| fk_permission_id      | BINARY(16) |
| is_active             | BOOLEAN    |
| is_deleted            | BOOLEAN    |
| deleted_at            | TIMESTAMP  |
| created_at            | TIMESTAMP  |
| created_by            | BINARY(16) |
| updated_at            | TIMESTAMP  |
| updated_by            | BINARY(16) |

---

# Constraints

## PRIMARY KEY

```text
pk_role_permissions
    (pk_role_permission_id)
```

---

## UNIQUE CONSTRAINT

```text
uq_role_permissions_role_permission
    (fk_role_id, fk_permission_id)
```

Meaning:

* same role cannot receive duplicate permission assignment

---

# Foreign Keys

## Role FK

```text
fk_role_permissions_role_id
```

references:

```text
roles.pk_role_id
```

---

## Permission FK

```text
fk_role_permissions_permission_id
```

references:

```text
permissions.pk_permission_id
```

---

# Indexes

## Role FK Index

```text
idx_role_permissions_role_id
    (fk_role_id)
```

---

## Permission FK Index

```text
idx_role_permissions_permission_id
    (fk_permission_id)
```

---

## Active Status

```text
idx_role_permissions_is_active
    (is_active)
```

---

## Deleted Status

```text
idx_role_permissions_is_deleted
    (is_deleted)
```

---

# Audit Strategy

Audit columns:

```text
created_by
updated_by
```

remain:

* non-FK audit fields

Reason:

* consistency with existing schema architecture

---

# Seed Data Dependency Order

```text
1. roles
2. permissions
3. role_permissions
```

---

# File Numbering Plan

## New Files

```text
036_create_permissions.sql
037_create_role_permissions.sql
```

---

# UUID Strategy

UUID storage:

```sql
UUID_TO_BIN(UUID())
```

UUID display:

```sql
BIN_TO_UUID(pk_column)
```

---

# Final Architecture Summary

Current centralized identity:

```text
users
```

Current centralized authorization:

```text
roles
permissions
role_permissions
```

Authorization enforcement:

```text
Spring Boot backend
```

Database responsibilities:

* storage
* relationships
* indexing
* integrity constraints

Application responsibilities:

* authorization checks
* soft delete cascade logic
* permission validation
* role validation

```
```
------------------

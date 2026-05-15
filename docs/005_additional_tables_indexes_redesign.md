code axis tables students related plan of action

# Code Axis - Student Module Finalized Database Design

# Core Architecture Decision

Authentication and common account/account-security data remain centralized in:

* `users`

Role/profile-specific data remain separated into:

* `employees`
* `students`

This architecture provides:

* centralized authentication
* reusable permissions/session handling
* clean normalization
* scalable role expansion
* simpler Spring Boot service architecture

---

# New Tables To Create

---

# 031_create_duration_units.sql

## Purpose

Normalized lookup table for duration units.

Examples:

* DAY
* WEEK
* MONTH
* YEAR

## Columns

| Column Name         | Data Type    |
| ------------------- | ------------ |
| pk_duration_unit_id | BINARY(16)   |
| unit_name           | VARCHAR(50)  |
| unit_description    | VARCHAR(255) |
| is_active           | BOOLEAN      |
| is_deleted          | BOOLEAN      |
| deleted_at          | TIMESTAMP    |
| created_at          | TIMESTAMP    |
| created_by          | BINARY(16)   |
| updated_at          | TIMESTAMP    |
| updated_by          | BINARY(16)   |

## Constraints

* PRIMARY KEY:

  * pk_duration_unit_id

* UNIQUE:

  * unit_name

---

# 032_create_courses.sql

## Purpose

Normalized courses/programs table.

Examples:

* Data Analytics
* Full Stack Development
* UI/UX Design
* Internship Program

## Relationships

* fk_department_id
  → departments.pk_department_id

* fk_duration_unit_id
  → duration_units.pk_duration_unit_id

## Columns

| Column Name         | Data Type     |
| ------------------- | ------------- |
| pk_course_id        | BINARY(16)    |
| fk_department_id    | BINARY(16)    |
| fk_duration_unit_id | BINARY(16)    |
| course_name         | VARCHAR(255)  |
| course_description  | TEXT          |
| duration_value      | INT           |
| fees_amount         | DECIMAL(15,2) |
| max_students        | INT           |
| start_date          | DATE          |
| end_date            | DATE          |
| is_active           | BOOLEAN       |
| is_deleted          | BOOLEAN       |
| deleted_at          | TIMESTAMP     |
| created_at          | TIMESTAMP     |
| created_by          | BINARY(16)    |
| updated_at          | TIMESTAMP     |
| updated_by          | BINARY(16)    |

## Constraints

* PRIMARY KEY:

  * pk_course_id

* UNIQUE:

  * course_name

---

# 033_create_student_statuses.sql

## Purpose

Normalized student statuses lookup table.

Examples:

* ACTIVE
* COMPLETED
* DROPPED
* ON_HOLD

## Columns

| Column Name          | Data Type    |
| -------------------- | ------------ |
| pk_student_status_id | BINARY(16)   |
| status_name          | VARCHAR(100) |
| status_description   | VARCHAR(255) |
| is_active            | BOOLEAN      |
| is_deleted           | BOOLEAN      |
| deleted_at           | TIMESTAMP    |
| created_at           | TIMESTAMP    |
| created_by           | BINARY(16)   |
| updated_at           | TIMESTAMP    |
| updated_by           | BINARY(16)   |

## Constraints

* PRIMARY KEY:

  * pk_student_status_id

* UNIQUE:

  * status_name

---

# 034_create_students.sql

## Purpose

Student profile/business table.

Authentication remains in:

* users

Student-specific information remains here.

---

## Relationships

### Student User Account

* fk_user_id
  → users.pk_user_id

Rules:

* NOT NULL
* UNIQUE

Meaning:

* one user account maps to one student profile

---

### Department

* fk_department_id
  → departments.pk_department_id

---

### Course

* fk_course_id
  → courses.pk_course_id

---

### Student Status

* fk_student_status_id
  → student_statuses.pk_student_status_id

---

### Mentor Employee

* fk_employee_id
  → employees.pk_employee_id

Meaning:

* mentor/supervisor employee

One employee:

* can mentor many students

---

# Student Columns

| Column Name                    | Data Type    |
| ------------------------------ | ------------ |
| pk_student_id                  | BINARY(16)   |
| fk_user_id                     | BINARY(16)   |
| fk_department_id               | BINARY(16)   |
| fk_course_id                   | BINARY(16)   |
| fk_student_status_id           | BINARY(16)   |
| fk_employee_id                 | BINARY(16)   |
| student_code                   | VARCHAR(50)  |
| first_name                     | VARCHAR(100) |
| last_name                      | VARCHAR(100) |
| date_of_birth                  | DATE         |
| joining_date                   | DATE         |
| academic_year                  | TINYINT      |
| semester                       | TINYINT      |
| passed_out_year                | YEAR         |
| cgpa                           | DECIMAL(5,2) |
| emergency_contact_name         | VARCHAR(100) |
| emergency_contact_phone_number | VARCHAR(20)  |
| address_line_1                 | VARCHAR(255) |
| address_line_2                 | VARCHAR(255) |
| city                           | VARCHAR(100) |
| state                          | VARCHAR(100) |
| postal_code                    | VARCHAR(20)  |
| country                        | VARCHAR(100) |
| is_active                      | BOOLEAN      |
| is_deleted                     | BOOLEAN      |
| deleted_at                     | TIMESTAMP    |
| created_at                     | TIMESTAMP    |
| created_by                     | BINARY(16)   |
| updated_at                     | TIMESTAMP    |
| updated_by                     | BINARY(16)   |

## Constraints

* PRIMARY KEY:

  * pk_student_id

* UNIQUE:

  * fk_user_id

* UNIQUE:

  * student_code

---

# 035_create_student_status_history.sql

## Purpose

Track student status transitions/history.

Examples:

* ACTIVE → ON_HOLD
* ON_HOLD → ACTIVE
* ACTIVE → COMPLETED

Similar to:

* task_status_history

## Columns

| Column Name                  | Data Type    |
| ---------------------------- | ------------ |
| pk_student_status_history_id | BINARY(16)   |
| fk_student_id                | BINARY(16)   |
| fk_student_status_id         | BINARY(16)   |
| changed_at                   | TIMESTAMP    |
| changed_by                   | BINARY(16)   |
| remarks                      | VARCHAR(500) |

## Relationships

* fk_student_id
  → students.pk_student_id

* fk_student_status_id
  → student_statuses.pk_student_status_id

---

# Existing Tables To Redesign

---

# project_members

## Current Problem

Currently supports employees only.

Current column:

* fk_employee_id

---

## Finalized Redesign

Replace:

* fk_employee_id

With:

* fk_user_id

Reason:

* both employees and students participate in projects

---

## Additional Design Decision

Allow:

* multiple project roles for same user inside same project

Therefore:

* remove/redesign existing unique constraint

Current constraint:

* uq_project_members_project_employee

---

## Reuse Existing Table

Reuse:

* project_member_roles

No separate:

* student_project_roles

table required.

---

# tasks

## Current Problem

Currently supports employees only.

Current column:

* fk_employee_id

---

## Finalized Redesign

Replace:

* fk_employee_id

With:

* fk_user_id

Reason:

* tasks can be assigned to:

  * employees
  * students

---

## Assignment Decision

One task:

* only one assignee

No assignment history table required currently.

---

# attendance_events

## Current Problem

Currently supports employees only.

Current column:

* fk_employee_id

---

## Finalized Redesign

Replace:

* fk_employee_id

With:

* fk_user_id

Reason:

* unified attendance system for:

  * employees
  * students

---

## Attendance Decision

Use:

* same attendance architecture
* same attendance event types

for both:

* employees
* students

---

# Existing Tables Already Compatible

These already correctly use:

* fk_user_id

No redesign required.

## Compatible Tables

* notifications
* task_comments
* attachments
* reports
* user_sessions
* password_reset_tokens
* email_verification_tokens

---

# Validation Strategy

## Finalized Decision

Validation handled in:

* Spring Boot service layer

Examples:

* only STUDENT role users allowed in students table
* only EMPLOYEE role users allowed in employees table

---

## Explicit Decision

Do NOT use:

* MySQL triggers
* heavy DB-side validation logic

Architecture approach:

* mixed JPA/service-layer validation

---

# Unified Final Architecture

## Central Identity

* users

---

## Role-Specific Profile Tables

* employees
* students

---

## Unified User Participation

All these systems now support both:

* employees
* students

through:

* fk_user_id

## Unified Systems

* projects
* tasks
* attendance
* notifications
* comments
* attachments
* reports

---

# File Numbering Plan

## New Files

* 031_create_duration_units.sql
* 032_create_courses.sql
* 033_create_student_statuses.sql
* 034_create_students.sql
* 035_create_student_status_history.sql

---

# Index File Placement Decision

Student-related indexes should be added into:

* 026_create_user_employee_indexes.sql

because:

* students are user/profile entities similar to employees

--------------------
Your new student architecture setup is complete.

Created:

* duration_units
* courses
* student_statuses
* students
* student_status_history

Redesigned:

* project_members
* tasks
* attendance_events

Updated indexes:

* lookup indexes
* user/student indexes

Current architecture is now unified around:

* `users`

and supports:

* employees
* students

consistently across:

* projects
* tasks
* attendance
* notifications
* comments
* attachments
* reports


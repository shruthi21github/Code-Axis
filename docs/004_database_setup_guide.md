# Code Axis Database Setup Guide

Project: Code Axis
Database: MySQL
Database Engineer: Dheeraj

---

# 1. Overview

This guide explains the database setup process for the Code Axis backend system.

The database architecture follows:

* SQL-first schema management
* UUIDv7 primary key strategy
* normalized relational design
* manual index optimization
* API-first backend architecture

---

# 2. Database Configuration

## Database Name

```sql
code_axis_db
```

## Character Set

```sql
utf8mb4
```

## Collation

```sql
utf8mb4_unicode_ci
```

## Timestamp Standard

* UTC timestamps only

---

# 3. Architecture Decisions

## UUID Strategy

* UUIDv7 generated in backend
* Stored in MySQL as:

```sql
BINARY(16)
```

## Naming Convention

* snake_case used for all database objects

## Soft Delete Strategy

Common columns:

* `is_deleted`
* `deleted_at`

## Audit Strategy

Common columns:

* `created_at`
* `created_by`
* `updated_at`
* `updated_by`

---

# 4. Module Structure

## Authentication Module

* roles
* users
* user_sessions
* password_reset_tokens

## Employee Module

* departments
* designations
* employees
* attendance_event_types
* attendance_events

## Project Module

* project_statuses
* project_member_roles
* projects
* project_members
* task_statuses
* task_priorities
* tasks
* task_status_history
* task_comments

## System Module

* notification_types
* notifications
* report_types
* reports
* attachments

---

# 5. Execution Order

Scripts should be executed in the following order:

1. Database creation
2. Lookup/master tables
3. Core business tables
4. Transactional tables
5. Index optimization scripts
6. Verification scripts

---

# 6. Index Optimization

Indexes implemented for:

* authentication queries
* JOIN optimization
* reporting queries
* dashboard filtering
* transactional history queries

Composite indexes implemented for:

* employee task queries
* attendance tracking
* notification filtering
* project-task filtering

---

# 7. Final Result

The database setup now supports:

* scalable backend APIs
* normalized relational structure
* optimized query performance
* future SaaS expansion
* enterprise-grade MySQL architecture


# Code Axis Database Schema Design Document

Project: Code Axis SaaS Backend  
Database: MySQL  
Database Engineer: Dheeraj  
Database Name: `code_axis_db`

----------

# 1. Database Schema Overview

The Code Axis backend follows a relational database schema design using MySQL.

Schema design goals:

-   Scalability
    
-   Maintainability
    
-   Normalization
    
-   Security
    
-   Performance optimization
    
-   Enterprise-grade relational architecture
    
-   API-first backend support
    

The database schema is fully SQL-first and manually controlled.

Hibernate/JPA automatic schema generation will be disabled.

----------

# 2. Database Architecture Decisions

## Database Strategy

-   Separate database per organization strategy
    
-   Current implementation targets single organization deployment
    
-   Single MySQL database:
    
    -   `code_axis_db`
        

## Schema Management Strategy

-   SQL-first architecture
    
-   Manual table creation
    
-   Manual index management
    
-   Manual foreign key management
    
-   Manual migration/versioning control
    

## Naming Convention

All database objects use:

-   `snake_case`
    

Examples:

-   `users`
    
-   `project_members`
    
-   `task_status_history`
    

----------

# 3. UUID Strategy

## Primary Key Design

-   UUIDv7 generated in backend application
    
-   Stored in MySQL using:
    
    -   `BINARY(16)`
        

## Primary Key Column Naming

Examples:

-   `pk_user_id`
    
-   `pk_project_id`
    
-   `pk_task_id`
    

## Primary Key Constraint Naming

Examples:

-   `pk_users`
    
-   `pk_projects`
    
-   `pk_tasks`
    

----------

# 4. Foreign Key Standards

## Foreign Key Column Naming

Examples:

-   `fk_role_id`
    
-   `fk_user_id`
    
-   `fk_project_id`
    

## Foreign Key Constraint Naming

Format:

-   `fk_table_name_column_name`
    

Examples:

-   `fk_users_role_id`
    
-   `fk_tasks_project_id`
    
-   `fk_employees_department_id`
    

## Relationship Rules

-   Strict foreign key constraints enabled
    
-   Referential integrity enforced at database level
    

----------

# 5. Common Table Standards

All major tables follow consistent structure.

## Audit Columns

-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

## Timestamp Standard

-   All timestamps stored in UTC
    

## Soft Delete Strategy

Soft delete enabled across major tables.

Common columns:

-   `is_deleted`
    
-   `deleted_at`
    

## Active Status Support

Common columns:

-   `is_active`
    

Purpose:

-   Business state management
    
-   Separate from soft delete logic
    

----------

# 6. Lookup Table Strategy

Lookup/master tables used instead of ENUM types.

Advantages:

-   Better normalization
    
-   Easier future expansion
    
-   Cleaner backend integration
    
-   Better reporting support
    

Examples:

-   `roles`
    
-   `task_statuses`
    
-   `project_statuses`
    
-   `task_priorities`
    
-   `attendance_event_types`
    

Lookup tables also include:

-   audit columns
    
-   soft delete support
    
-   active status support
    

----------

# 7. Database Modules and Tables

----------

# Authentication Module

## roles

Purpose:

-   System role master table
    

Planned Columns:

-   `pk_role_id`
    
-   `role_name`
    
-   `role_description`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

----------

## users

Purpose:

-   Authentication and account management
    

Planned Columns:

-   `pk_user_id`
    
-   `fk_role_id`
    
-   `username`
    
-   `email`
    
-   `phone_number`
    
-   `password_hash`
    
-   `is_locked`
    
-   `locked_at`
    
-   `last_login_at`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

Rules:

-   `username` UNIQUE
    
-   `email` UNIQUE

- 	strict E.164-ready format support

----------

## user_sessions

Purpose:

-   Active session and token tracking
    

Planned Columns:

-   `pk_user_session_id`
    
-   `fk_user_id`
    
-   `jwt_token_hash`
    
-   `expires_at`
    
-   `revoked_at`
    
-   `is_active`
    
-   `created_at`
    
-   `created_by`
    

----------

## password_reset_tokens

Purpose:

-   Password reset flow support
    

Planned Columns:

-   `pk_password_reset_token_id`
    
-   `fk_user_id`
    
-   `reset_token_hash`
    
-   `expires_at`
    
-   `used_at`
    
-   `is_active`
    
-   `created_at`
    

----------

# Employee Module

## departments

Purpose:

-   Department master table
    

Planned Columns:

-   `pk_department_id`
    
-   `department_name`
    
-   `department_description`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

----------

## designations

Purpose:

-   Employee designation/job title master table
    

Planned Columns:

-   `pk_designation_id`
    
-   `designation_name`
    
-   `designation_description`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

----------

## employees

Purpose:

-   Employee business profile information
    

Planned Columns:

-   `pk_employee_id`
    
-   `fk_user_id`
    
-   `fk_department_id`
    
-   `fk_designation_id`
    
-   `fk_manager_employee_id`
    
-   `employee_code`
    
-   `first_name`
    
-   `last_name`
    
-   `date_of_birth`
    
-   `joining_date`
    
-   `salary`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

Rules:

-   One-to-One relationship with users
    
-   `fk_user_id` UNIQUE
    
-   Self-referencing manager hierarchy supported
    

----------

## attendance_event_types

Purpose:

-   Attendance event type master table
    

Examples:

-   CHECK_IN
    
-   CHECK_OUT
    

Planned Columns:

-   `pk_attendance_event_type_id`
    
-   `event_type_name`
    
-   `event_type_description`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

----------

## attendance_events

Purpose:

-   Attendance event tracking
    

Planned Columns:

-   `pk_attendance_event_id`
    
-   `fk_employee_id`
    
-   `fk_attendance_event_type_id`
    
-   `event_at`
    
-   `notes`
    
-   `created_at`
    
-   `created_by`
    

Architecture:

-   Event-based attendance system
    
-   No device/IP/location tracking
    

----------

# Project Module

## project_statuses

Purpose:

-   Project status master table
    

Examples:

-   planned
    
-   active
    
-   completed
    
-   on_hold
    

Planned Columns:

-   `pk_project_status_id`
    
-   `status_name`
    
-   `status_description`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

----------

## projects

Purpose:

-   Project management table
    

Planned Columns:

-   `pk_project_id`
    
-   `fk_project_status_id`
    
-   `project_code`
    
-   `project_name`
    
-   `project_description`
    
-   `start_at`
    
-   `deadline_at`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

Rules:

-   `project_code` should be UNIQUE
    

----------

## project_member_roles

Purpose:

-   Project member role master table
    

Examples:

-   manager
    
-   developer
    
-   tester
    

Planned Columns:

-   `pk_project_member_role_id`
    
-   `role_name`
    
-   `role_description`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

----------

## project_members

Purpose:

-   Employee-project bridge table
    

Planned Columns:

-   `pk_project_member_id`
    
-   `fk_project_id`
    
-   `fk_employee_id`
    
-   `fk_project_member_role_id`
    
-   `assigned_at`
    
-   `is_active`
    
-   `created_at`
    
-   `created_by`
    

Architecture:

-   Many-to-Many bridge table
    
-   Employees ↔ Projects
    

----------

## task_statuses

Purpose:

-   Task status master table
    

Examples:

-   pending
    
-   in_progress
    
-   completed
    

Planned Columns:

-   `pk_task_status_id`
    
-   `status_name`
    
-   `status_description`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

----------

## task_priorities

Purpose:

-   Task priority master table
    

Examples:

-   low
    
-   medium
    
-   high
    
-   critical
    

Planned Columns:

-   `pk_task_priority_id`
    
-   `priority_name`
    
-   `priority_description`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

----------

## tasks

Purpose:

-   Task management table
    

Planned Columns:

-   `pk_task_id`
    
-   `fk_project_id`
    
-   `fk_employee_id`
    
-   `fk_task_status_id`
    
-   `fk_task_priority_id`
    
-   `task_title`
    
-   `task_description`
    
-   `estimated_hours`
    
-   `actual_hours`
    
-   `start_at`
    
-   `deadline_at`
    
-   `completed_at`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

Architecture:

-   One task assigned to one employee
    
-   No subtask hierarchy
    

----------

## task_status_history

Purpose:

-   Task status audit/history tracking
    

Planned Columns:

-   `pk_task_status_history_id`
    
-   `fk_task_id`
    
-   `fk_task_status_id`
    
-   `changed_at`
    
-   `changed_by`
    
-   `remarks`
    

----------

## task_comments

Purpose:

-   Task discussion/comments
    

Planned Columns:

-   `pk_task_comment_id`
    
-   `fk_task_id`
    
-   `fk_user_id`
    
-   `comment_text`
    
-   `is_edited`
    
-   `edited_at`
    
-   `created_at`
    
-   `created_by`
    

Architecture:

-   Latest comment only
    
-   No comment history table
    

----------

# System Module

## notification_types

Purpose:

-   Notification type master table
    

Examples:

-   task_assigned
    
-   task_completed
    
-   system_alert
    

Planned Columns:

-   `pk_notification_type_id`
    
-   `type_name`
    
-   `type_description`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

----------

## notifications

Purpose:

-   User notification system
    

Planned Columns:

-   `pk_notification_id`
    
-   `fk_user_id`
    
-   `fk_notification_type_id`
    
-   `title`
    
-   `message`
    
-   `is_read`
    
-   `read_at`
    
-   `created_at`
    
-   `created_by`
    

----------

## report_types

Purpose:

-   Report type master table
    

Examples:

-   attendance_report
    
-   performance_report
    
-   project_report
    

Planned Columns:

-   `pk_report_type_id`
    
-   `type_name`
    
-   `type_description`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    
-   `updated_at`
    
-   `updated_by`
    

----------

## reports

Purpose:

-   Report metadata storage
    

Planned Columns:

-   `pk_report_id`
    
-   `fk_user_id`
    
-   `fk_report_type_id`
    
-   `report_name`
    
-   `file_name`
    
-   `file_path`
    
-   `generated_at`
    
-   `created_at`
    
-   `created_by`
    

Architecture:

-   Metadata-only storage
    
-   Actual files stored externally
    

----------

## attachments

Purpose:

-   Generic attachment management
    

Planned Columns:

-   `pk_attachment_id`
    
-   `fk_user_id`
    
-   `entity_type`
    
-   `entity_id`
    
-   `file_name`
    
-   `file_path`
    
-   `mime_type`
    
-   `file_size`
    
-   `uploaded_at`
    
-   `is_active`
    
-   `is_deleted`
    
-   `deleted_at`
    
-   `created_at`
    
-   `created_by`
    

Architecture:

-   Generic polymorphic attachment system
    
-   Supports:
    
    -   tasks
        
    -   projects
        
    -   reports
        
    -   future modules
        

----------

# 8. Relationship Architecture

## One-to-Many Relationships

-   roles → users
    
-   departments → employees
    
-   designations → employees
    
-   employees → attendance_events
    
-   projects → tasks
    
-   employees → tasks
    
-   tasks → task_comments
    
-   users → notifications
    
-   users → reports
    

## Many-to-Many Relationships

-   employees ↔ projects
    
-   Bridge table:
    
    -   project_members
        

## One-to-One Relationships

-   users ↔ employees
    

## Self-Referencing Relationships

-   employees → employees
    
-   Manager hierarchy support
    

----------

# 9. Important Design Decisions

## User and Employee Separation

Authentication and employee profile data are separated.

Reason:

-   Better normalization
    
-   Cleaner architecture
    
-   Flexible role management
    
-   Admin users may not require employee profile
    

## Attendance Architecture

Attendance uses event-based structure instead of daily row structure.

Advantages:

-   Better scalability
    
-   Flexible future enhancements
    
-   Easier audit support
    

## Generic Attachment Architecture

Single attachment table supports multiple modules using polymorphic linking.

## Task Status Tracking

Current status stored in:

-   `tasks`
    

History stored in:

-   `task_status_history`
    

----------

# 10. Future Scalability Support

Schema supports future expansion for:

-   SaaS scaling
    
-   Payment systems
    
-   Email systems
    
-   File storage systems
    
-   Reporting engines
    
-   Workflow automation
    
-   Security enhancements
    
-   Activity logging
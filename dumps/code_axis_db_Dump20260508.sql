CREATE DATABASE  IF NOT EXISTS `code_axis_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `code_axis_db`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: code_axis_db
-- ------------------------------------------------------
-- Server version	8.4.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachments` (
  `pk_attachment_id` binary(16) NOT NULL,
  `fk_user_id` binary(16) NOT NULL,
  `entity_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` binary(16) NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_attachment_id`),
  KEY `fk_attachments_user_id` (`fk_user_id`),
  CONSTRAINT `fk_attachments_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance_event_types`
--

DROP TABLE IF EXISTS `attendance_event_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance_event_types` (
  `pk_attendance_event_type_id` binary(16) NOT NULL,
  `event_type_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_type_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_attendance_event_type_id`),
  UNIQUE KEY `uq_attendance_event_types_event_type_name` (`event_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_event_types`
--

LOCK TABLES `attendance_event_types` WRITE;
/*!40000 ALTER TABLE `attendance_event_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance_event_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance_events`
--

DROP TABLE IF EXISTS `attendance_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance_events` (
  `pk_attendance_event_id` binary(16) NOT NULL,
  `fk_employee_id` binary(16) NOT NULL,
  `fk_attendance_event_type_id` binary(16) NOT NULL,
  `event_at` timestamp NOT NULL,
  `notes` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_attendance_event_id`),
  KEY `fk_attendance_events_employee_id` (`fk_employee_id`),
  KEY `fk_attendance_events_event_type_id` (`fk_attendance_event_type_id`),
  CONSTRAINT `fk_attendance_events_employee_id` FOREIGN KEY (`fk_employee_id`) REFERENCES `employees` (`pk_employee_id`),
  CONSTRAINT `fk_attendance_events_event_type_id` FOREIGN KEY (`fk_attendance_event_type_id`) REFERENCES `attendance_event_types` (`pk_attendance_event_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_events`
--

LOCK TABLES `attendance_events` WRITE;
/*!40000 ALTER TABLE `attendance_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `pk_department_id` binary(16) NOT NULL,
  `department_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_department_id`),
  UNIQUE KEY `uq_departments_department_name` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `designations`
--

DROP TABLE IF EXISTS `designations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `designations` (
  `pk_designation_id` binary(16) NOT NULL,
  `designation_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `designation_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_designation_id`),
  UNIQUE KEY `uq_designations_designation_name` (`designation_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `designations`
--

LOCK TABLES `designations` WRITE;
/*!40000 ALTER TABLE `designations` DISABLE KEYS */;
/*!40000 ALTER TABLE `designations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `pk_employee_id` binary(16) NOT NULL,
  `fk_user_id` binary(16) NOT NULL,
  `fk_department_id` binary(16) NOT NULL,
  `fk_designation_id` binary(16) NOT NULL,
  `fk_manager_employee_id` binary(16) DEFAULT NULL,
  `employee_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `joining_date` date NOT NULL,
  `salary` decimal(15,2) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_employee_id`),
  UNIQUE KEY `uq_employees_fk_user_id` (`fk_user_id`),
  UNIQUE KEY `uq_employees_employee_code` (`employee_code`),
  KEY `fk_employees_department_id` (`fk_department_id`),
  KEY `fk_employees_designation_id` (`fk_designation_id`),
  KEY `fk_employees_manager_employee_id` (`fk_manager_employee_id`),
  CONSTRAINT `fk_employees_department_id` FOREIGN KEY (`fk_department_id`) REFERENCES `departments` (`pk_department_id`),
  CONSTRAINT `fk_employees_designation_id` FOREIGN KEY (`fk_designation_id`) REFERENCES `designations` (`pk_designation_id`),
  CONSTRAINT `fk_employees_manager_employee_id` FOREIGN KEY (`fk_manager_employee_id`) REFERENCES `employees` (`pk_employee_id`),
  CONSTRAINT `fk_employees_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_types`
--

DROP TABLE IF EXISTS `notification_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_types` (
  `pk_notification_type_id` binary(16) NOT NULL,
  `type_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_notification_type_id`),
  UNIQUE KEY `uq_notification_types_type_name` (`type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_types`
--

LOCK TABLES `notification_types` WRITE;
/*!40000 ALTER TABLE `notification_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `pk_notification_id` binary(16) NOT NULL,
  `fk_user_id` binary(16) NOT NULL,
  `fk_notification_type_id` binary(16) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_notification_id`),
  KEY `fk_notifications_user_id` (`fk_user_id`),
  KEY `fk_notifications_notification_type_id` (`fk_notification_type_id`),
  CONSTRAINT `fk_notifications_notification_type_id` FOREIGN KEY (`fk_notification_type_id`) REFERENCES `notification_types` (`pk_notification_type_id`),
  CONSTRAINT `fk_notifications_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `pk_password_reset_token_id` binary(16) NOT NULL,
  `fk_user_id` binary(16) NOT NULL,
  `reset_token_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` timestamp NOT NULL,
  `used_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_password_reset_token_id`),
  KEY `fk_password_reset_tokens_user_id` (`fk_user_id`),
  CONSTRAINT `fk_password_reset_tokens_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_member_roles`
--

DROP TABLE IF EXISTS `project_member_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_member_roles` (
  `pk_project_member_role_id` binary(16) NOT NULL,
  `role_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_project_member_role_id`),
  UNIQUE KEY `uq_project_member_roles_role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_member_roles`
--

LOCK TABLES `project_member_roles` WRITE;
/*!40000 ALTER TABLE `project_member_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_member_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_members`
--

DROP TABLE IF EXISTS `project_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_members` (
  `pk_project_member_id` binary(16) NOT NULL,
  `fk_project_id` binary(16) NOT NULL,
  `fk_employee_id` binary(16) NOT NULL,
  `fk_project_member_role_id` binary(16) NOT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_project_member_id`),
  UNIQUE KEY `uq_project_members_project_employee` (`fk_project_id`,`fk_employee_id`),
  KEY `fk_project_members_employee_id` (`fk_employee_id`),
  KEY `fk_project_members_project_member_role_id` (`fk_project_member_role_id`),
  CONSTRAINT `fk_project_members_employee_id` FOREIGN KEY (`fk_employee_id`) REFERENCES `employees` (`pk_employee_id`),
  CONSTRAINT `fk_project_members_project_id` FOREIGN KEY (`fk_project_id`) REFERENCES `projects` (`pk_project_id`),
  CONSTRAINT `fk_project_members_project_member_role_id` FOREIGN KEY (`fk_project_member_role_id`) REFERENCES `project_member_roles` (`pk_project_member_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_members`
--

LOCK TABLES `project_members` WRITE;
/*!40000 ALTER TABLE `project_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_statuses`
--

DROP TABLE IF EXISTS `project_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_statuses` (
  `pk_project_status_id` binary(16) NOT NULL,
  `status_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_project_status_id`),
  UNIQUE KEY `uq_project_statuses_status_name` (`status_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_statuses`
--

LOCK TABLES `project_statuses` WRITE;
/*!40000 ALTER TABLE `project_statuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `pk_project_id` binary(16) NOT NULL,
  `fk_project_status_id` binary(16) NOT NULL,
  `project_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_description` text COLLATE utf8mb4_unicode_ci,
  `start_at` timestamp NULL DEFAULT NULL,
  `deadline_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_project_id`),
  UNIQUE KEY `uq_projects_project_code` (`project_code`),
  KEY `fk_projects_project_status_id` (`fk_project_status_id`),
  CONSTRAINT `fk_projects_project_status_id` FOREIGN KEY (`fk_project_status_id`) REFERENCES `project_statuses` (`pk_project_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_types`
--

DROP TABLE IF EXISTS `report_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_types` (
  `pk_report_type_id` binary(16) NOT NULL,
  `type_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_report_type_id`),
  UNIQUE KEY `uq_report_types_type_name` (`type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_types`
--

LOCK TABLES `report_types` WRITE;
/*!40000 ALTER TABLE `report_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `pk_report_id` binary(16) NOT NULL,
  `fk_user_id` binary(16) NOT NULL,
  `fk_report_type_id` binary(16) NOT NULL,
  `report_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `generated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_report_id`),
  KEY `fk_reports_user_id` (`fk_user_id`),
  KEY `fk_reports_report_type_id` (`fk_report_type_id`),
  CONSTRAINT `fk_reports_report_type_id` FOREIGN KEY (`fk_report_type_id`) REFERENCES `report_types` (`pk_report_type_id`),
  CONSTRAINT `fk_reports_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `pk_role_id` binary(16) NOT NULL,
  `role_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_role_id`),
  UNIQUE KEY `uq_roles_role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_comments`
--

DROP TABLE IF EXISTS `task_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_comments` (
  `pk_task_comment_id` binary(16) NOT NULL,
  `fk_task_id` binary(16) NOT NULL,
  `fk_user_id` binary(16) NOT NULL,
  `comment_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_edited` tinyint(1) NOT NULL DEFAULT '0',
  `edited_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_task_comment_id`),
  KEY `fk_task_comments_task_id` (`fk_task_id`),
  KEY `fk_task_comments_user_id` (`fk_user_id`),
  CONSTRAINT `fk_task_comments_task_id` FOREIGN KEY (`fk_task_id`) REFERENCES `tasks` (`pk_task_id`),
  CONSTRAINT `fk_task_comments_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_comments`
--

LOCK TABLES `task_comments` WRITE;
/*!40000 ALTER TABLE `task_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_priorities`
--

DROP TABLE IF EXISTS `task_priorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_priorities` (
  `pk_task_priority_id` binary(16) NOT NULL,
  `priority_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_task_priority_id`),
  UNIQUE KEY `uq_task_priorities_priority_name` (`priority_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_priorities`
--

LOCK TABLES `task_priorities` WRITE;
/*!40000 ALTER TABLE `task_priorities` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_priorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_status_history`
--

DROP TABLE IF EXISTS `task_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_status_history` (
  `pk_task_status_history_id` binary(16) NOT NULL,
  `fk_task_id` binary(16) NOT NULL,
  `fk_task_status_id` binary(16) NOT NULL,
  `changed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changed_by` binary(16) DEFAULT NULL,
  `remarks` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pk_task_status_history_id`),
  KEY `fk_task_status_history_task_id` (`fk_task_id`),
  KEY `fk_task_status_history_status_id` (`fk_task_status_id`),
  CONSTRAINT `fk_task_status_history_status_id` FOREIGN KEY (`fk_task_status_id`) REFERENCES `task_statuses` (`pk_task_status_id`),
  CONSTRAINT `fk_task_status_history_task_id` FOREIGN KEY (`fk_task_id`) REFERENCES `tasks` (`pk_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_status_history`
--

LOCK TABLES `task_status_history` WRITE;
/*!40000 ALTER TABLE `task_status_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_statuses`
--

DROP TABLE IF EXISTS `task_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_statuses` (
  `pk_task_status_id` binary(16) NOT NULL,
  `status_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_task_status_id`),
  UNIQUE KEY `uq_task_statuses_status_name` (`status_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_statuses`
--

LOCK TABLES `task_statuses` WRITE;
/*!40000 ALTER TABLE `task_statuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `pk_task_id` binary(16) NOT NULL,
  `fk_project_id` binary(16) NOT NULL,
  `fk_employee_id` binary(16) NOT NULL,
  `fk_task_status_id` binary(16) NOT NULL,
  `fk_task_priority_id` binary(16) NOT NULL,
  `task_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `task_description` text COLLATE utf8mb4_unicode_ci,
  `estimated_hours` decimal(10,2) DEFAULT NULL,
  `actual_hours` decimal(10,2) DEFAULT NULL,
  `start_at` timestamp NULL DEFAULT NULL,
  `deadline_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_task_id`),
  KEY `fk_tasks_project_id` (`fk_project_id`),
  KEY `fk_tasks_employee_id` (`fk_employee_id`),
  KEY `fk_tasks_task_status_id` (`fk_task_status_id`),
  KEY `fk_tasks_task_priority_id` (`fk_task_priority_id`),
  CONSTRAINT `fk_tasks_employee_id` FOREIGN KEY (`fk_employee_id`) REFERENCES `employees` (`pk_employee_id`),
  CONSTRAINT `fk_tasks_project_id` FOREIGN KEY (`fk_project_id`) REFERENCES `projects` (`pk_project_id`),
  CONSTRAINT `fk_tasks_task_priority_id` FOREIGN KEY (`fk_task_priority_id`) REFERENCES `task_priorities` (`pk_task_priority_id`),
  CONSTRAINT `fk_tasks_task_status_id` FOREIGN KEY (`fk_task_status_id`) REFERENCES `task_statuses` (`pk_task_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_sessions`
--

DROP TABLE IF EXISTS `user_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_sessions` (
  `pk_user_session_id` binary(16) NOT NULL,
  `fk_user_id` binary(16) NOT NULL,
  `jwt_token_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` timestamp NOT NULL,
  `revoked_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_user_session_id`),
  KEY `fk_user_sessions_user_id` (`fk_user_id`),
  CONSTRAINT `fk_user_sessions_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_sessions`
--

LOCK TABLES `user_sessions` WRITE;
/*!40000 ALTER TABLE `user_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `pk_user_id` binary(16) NOT NULL,
  `fk_role_id` binary(16) NOT NULL,
  `username` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `locked_at` timestamp NULL DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_user_id`),
  UNIQUE KEY `uq_users_username` (`username`),
  UNIQUE KEY `uq_users_email` (`email`),
  KEY `fk_users_role_id` (`fk_role_id`),
  CONSTRAINT `fk_users_role_id` FOREIGN KEY (`fk_role_id`) REFERENCES `roles` (`pk_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'code_axis_db'
--

--
-- Dumping routines for database 'code_axis_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-08 15:53:19

-- MySQL dump 10.13  Distrib 8.4.9, for Win64 (x86_64)
--
-- Host: localhost    Database: code_axis_db
-- ------------------------------------------------------
-- Server version	8.4.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Drop if exists Current Database: code_axis_db
--

DROP DATABASE IF EXISTS code_axis_db;

--
-- Current Database: `code_axis_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `code_axis_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `code_axis_db`;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachments` (
  `pk_attachment_id` binary(16) NOT NULL,
  `fk_user_id` binary(16) NOT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` binary(16) NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_attachment_id`),
  KEY `idx_attachments_user_id` (`fk_user_id`),
  KEY `idx_attachments_entity_type` (`entity_type`),
  KEY `idx_attachments_entity_id` (`entity_id`),
  KEY `idx_attachments_entity_type_entity_id` (`entity_type`,`entity_id`),
  KEY `idx_attachments_is_deleted` (`is_deleted`),
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
  `event_type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_type_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_attendance_event_type_id`),
  UNIQUE KEY `uq_attendance_event_types_event_type_name` (`event_type_name`),
  KEY `idx_attendance_event_types_is_active` (`is_active`)
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
  `fk_user_id` binary(16) NOT NULL,
  `fk_attendance_event_type_id` binary(16) NOT NULL,
  `event_at` timestamp NOT NULL,
  `notes` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_attendance_event_id`),
  KEY `idx_attendance_events_event_type_id` (`fk_attendance_event_type_id`),
  KEY `idx_attendance_events_event_at` (`event_at`),
  KEY `idx_attendance_events_user_id` (`fk_user_id`),
  KEY `idx_attendance_events_user_id_event_at` (`fk_user_id`,`event_at`),
  CONSTRAINT `fk_attendance_events_event_type_id` FOREIGN KEY (`fk_attendance_event_type_id`) REFERENCES `attendance_event_types` (`pk_attendance_event_type_id`),
  CONSTRAINT `fk_attendance_events_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`)
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
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `pk_course_id` binary(16) NOT NULL,
  `fk_department_id` binary(16) NOT NULL,
  `fk_duration_unit_id` binary(16) NOT NULL,
  `course_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_description` text COLLATE utf8mb4_unicode_ci,
  `duration_value` int NOT NULL,
  `fees_amount` decimal(15,2) DEFAULT NULL,
  `max_students` int DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_course_id`),
  UNIQUE KEY `uq_courses_course_name` (`course_name`),
  KEY `idx_courses_department_id` (`fk_department_id`),
  KEY `idx_courses_duration_unit_id` (`fk_duration_unit_id`),
  KEY `idx_courses_is_active` (`is_active`),
  KEY `idx_courses_is_deleted` (`is_deleted`),
  KEY `idx_courses_start_date` (`start_date`),
  KEY `idx_courses_end_date` (`end_date`),
  KEY `idx_courses_department_id_is_active` (`fk_department_id`,`is_active`),
  CONSTRAINT `fk_courses_department_id` FOREIGN KEY (`fk_department_id`) REFERENCES `departments` (`pk_department_id`),
  CONSTRAINT `fk_courses_duration_unit_id` FOREIGN KEY (`fk_duration_unit_id`) REFERENCES `duration_units` (`pk_duration_unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `pk_department_id` binary(16) NOT NULL,
  `department_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_department_id`),
  UNIQUE KEY `uq_departments_department_name` (`department_name`),
  KEY `idx_departments_is_active` (`is_active`),
  KEY `idx_departments_is_deleted` (`is_deleted`)
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
  `designation_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `designation_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_designation_id`),
  UNIQUE KEY `uq_designations_designation_name` (`designation_name`),
  KEY `idx_designations_is_active` (`is_active`),
  KEY `idx_designations_is_deleted` (`is_deleted`)
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
-- Table structure for table `duration_units`
--

DROP TABLE IF EXISTS `duration_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `duration_units` (
  `pk_duration_unit_id` binary(16) NOT NULL,
  `unit_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_duration_unit_id`),
  UNIQUE KEY `uq_duration_units_unit_name` (`unit_name`),
  KEY `idx_duration_units_is_active` (`is_active`),
  KEY `idx_duration_units_is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duration_units`
--

LOCK TABLES `duration_units` WRITE;
/*!40000 ALTER TABLE `duration_units` DISABLE KEYS */;
/*!40000 ALTER TABLE `duration_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_verification_tokens`
--

DROP TABLE IF EXISTS `email_verification_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_verification_tokens` (
  `pk_email_verification_token_id` binary(16) NOT NULL,
  `fk_user_id` binary(16) NOT NULL,
  `verification_token_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` timestamp NOT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_email_verification_token_id`),
  KEY `idx_email_verification_tokens_user_id` (`fk_user_id`),
  KEY `idx_email_verification_tokens_expires_at` (`expires_at`),
  KEY `idx_email_verification_tokens_is_active` (`is_active`),
  CONSTRAINT `fk_email_verification_tokens_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_verification_tokens`
--

LOCK TABLES `email_verification_tokens` WRITE;
/*!40000 ALTER TABLE `email_verification_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_verification_tokens` ENABLE KEYS */;
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
  `employee_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  KEY `idx_employees_department_id` (`fk_department_id`),
  KEY `idx_employees_designation_id` (`fk_designation_id`),
  KEY `idx_employees_manager_employee_id` (`fk_manager_employee_id`),
  KEY `idx_employees_is_active` (`is_active`),
  KEY `idx_employees_is_deleted` (`is_deleted`),
  KEY `idx_employees_joining_date` (`joining_date`),
  KEY `idx_employees_department_active` (`fk_department_id`,`is_active`),
  KEY `idx_employees_manager_active` (`fk_manager_employee_id`,`is_active`),
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
  `type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_notification_type_id`),
  UNIQUE KEY `uq_notification_types_type_name` (`type_name`),
  KEY `idx_notification_types_is_active` (`is_active`)
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
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_notification_id`),
  KEY `idx_notifications_user_id` (`fk_user_id`),
  KEY `idx_notifications_notification_type_id` (`fk_notification_type_id`),
  KEY `idx_notifications_is_read` (`is_read`),
  KEY `idx_notifications_user_id_is_read` (`fk_user_id`,`is_read`),
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
  `reset_token_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` timestamp NOT NULL,
  `used_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_password_reset_token_id`),
  KEY `idx_password_reset_tokens_user_id` (`fk_user_id`),
  KEY `idx_password_reset_tokens_expires_at` (`expires_at`),
  KEY `idx_password_reset_tokens_is_active` (`is_active`),
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
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `pk_permission_id` binary(16) NOT NULL,
  `module_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_permission_id`),
  UNIQUE KEY `uq_permissions_permission_name` (`permission_name`),
  UNIQUE KEY `uq_permissions_module_name_action_name` (`module_name`,`action_name`),
  KEY `idx_permissions_module_name` (`module_name`),
  KEY `idx_permissions_is_active` (`is_active`),
  KEY `idx_permissions_is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','auth','login','auth.login','Login permission',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','auth','logout','auth.logout','Logout permission',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','auth','refresh_token','auth.refresh_token','Refresh token permission',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','auth','verify_email','auth.verify_email','Verify email permission',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','auth','reset_password','auth.reset_password','Reset password permission',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','roles','create','roles.create','Create roles',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','roles','read','roles.read','Read roles',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','roles','update','roles.update','Update roles',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0	','roles','delete','roles.delete','Delete roles',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','permissions','create','permissions.create','Create permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','permissions','read','permissions.read','Read permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','permissions','update','permissions.update','Update permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','permissions','delete','permissions.delete','Delete permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','role_permissions','create','role_permissions.create','Create role permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','role_permissions','read','role_permissions.read','Read role permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','role_permissions','update','role_permissions.update','Update role permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','role_permissions','delete','role_permissions.delete','Delete role permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','users','create','users.create','Create users',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0','users','read','users.read','Read users',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0 ','users','update','users.update','Update users',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0!','users','delete','users.delete','Delete users',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0\"','employees','create','employees.create','Create employees',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0#','employees','read','employees.read','Read employees',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0$','employees','update','employees.update','Update employees',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0%','employees','delete','employees.delete','Delete employees',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0&','students','create','students.create','Create students',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0\'','students','read','students.read','Read students',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0(','students','update','students.update','Update students',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0)','students','delete','students.delete','Delete students',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\00','projects','create','projects.create','Create projects',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\01','projects','read','projects.read','Read projects',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\02','projects','update','projects.update','Update projects',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\03','projects','delete','projects.delete','Delete projects',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\04','tasks','create','tasks.create','Create tasks',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\05','tasks','read','tasks.read','Read tasks',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\06','tasks','update','tasks.update','Update tasks',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\07','tasks','delete','tasks.delete','Delete tasks',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\08','tasks','assign','tasks.assign','Assign tasks',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\09','tasks','complete','tasks.complete','Complete tasks',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0@','reports','create','reports.create','Create reports',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0A','reports','read','reports.read','Read reports',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0B','reports','update','reports.update','Update reports',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0C','reports','delete','reports.delete','Delete reports',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0D','reports','export','reports.export','Export reports',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0E','reports','download','reports.download','Download reports',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0F','system','settings_update','system.settings_update','Update system settings',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0G','system','health_check','system.health_check','System health check',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0H','database','backup','database.backup','Backup database',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0I','database','restore','database.restore','Restore database',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0P','seeddata','execute','seeddata.execute','Execute seed data',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0Q','migration','execute','migration.execute','Execute migrations',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0R','indexes','verify','indexes.verify','Verify indexes',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(_binary '–\Ô\× \0p\0€\0\0\0\0\0\0S','audit_logs','read','audit_logs.read','Read audit logs',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL);
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_member_roles`
--

DROP TABLE IF EXISTS `project_member_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_member_roles` (
  `pk_project_member_role_id` binary(16) NOT NULL,
  `role_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_project_member_role_id`),
  UNIQUE KEY `uq_project_member_roles_role_name` (`role_name`),
  KEY `idx_project_member_roles_is_active` (`is_active`)
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
  `fk_user_id` binary(16) NOT NULL,
  `fk_project_member_role_id` binary(16) NOT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_project_member_id`),
  KEY `idx_project_members_project_id` (`fk_project_id`),
  KEY `idx_project_members_role_id` (`fk_project_member_role_id`),
  KEY `idx_project_members_user_id` (`fk_user_id`),
  KEY `idx_project_members_project_id_user_id` (`fk_project_id`,`fk_user_id`),
  CONSTRAINT `fk_project_members_project_id` FOREIGN KEY (`fk_project_id`) REFERENCES `projects` (`pk_project_id`),
  CONSTRAINT `fk_project_members_project_member_role_id` FOREIGN KEY (`fk_project_member_role_id`) REFERENCES `project_member_roles` (`pk_project_member_role_id`),
  CONSTRAINT `fk_project_members_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`)
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
  `status_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_project_status_id`),
  UNIQUE KEY `uq_project_statuses_status_name` (`status_name`),
  KEY `idx_project_statuses_is_active` (`is_active`)
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
  `project_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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
  KEY `idx_projects_project_status_id` (`fk_project_status_id`),
  KEY `idx_projects_is_active` (`is_active`),
  KEY `idx_projects_is_deleted` (`is_deleted`),
  KEY `idx_projects_deadline_at` (`deadline_at`),
  KEY `idx_projects_project_status_id_is_active` (`fk_project_status_id`,`is_active`),
  KEY `idx_projects_start_at_deadline_at` (`start_at`,`deadline_at`),
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
  `type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_report_type_id`),
  UNIQUE KEY `uq_report_types_type_name` (`type_name`),
  KEY `idx_report_types_is_active` (`is_active`)
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
  `report_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `generated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_report_id`),
  KEY `idx_reports_user_id` (`fk_user_id`),
  KEY `idx_reports_report_type_id` (`fk_report_type_id`),
  KEY `idx_reports_generated_at` (`generated_at`),
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
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `pk_role_permission_id` binary(16) NOT NULL,
  `fk_role_id` binary(16) NOT NULL,
  `fk_permission_id` binary(16) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_role_permission_id`),
  UNIQUE KEY `uq_role_permissions_role_permission` (`fk_role_id`,`fk_permission_id`),
  KEY `idx_role_permissions_role_id` (`fk_role_id`),
  KEY `idx_role_permissions_permission_id` (`fk_permission_id`),
  KEY `idx_role_permissions_is_active` (`is_active`),
  KEY `idx_role_permissions_is_deleted` (`is_deleted`),
  CONSTRAINT `fk_role_permissions_permission_id` FOREIGN KEY (`fk_permission_id`) REFERENCES `permissions` (`pk_permission_id`),
  CONSTRAINT `fk_role_permissions_role_id` FOREIGN KEY (`fk_role_id`) REFERENCES `roles` (`pk_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0S',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0H',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0I',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0	',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0\"',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0%',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0#',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0$',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0R',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0Q',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\00',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0 ',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\03',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0!',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\01',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0\"',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\02',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0#',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0@',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0$',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0C',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0%',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0E',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0&',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0D',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0\'',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0A',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0(',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0B',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0)',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\00',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\01',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\02',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\03',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\04',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0	',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\05',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\06',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\07',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0P',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\08',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0&',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\09',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0)',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0@',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0\'',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0A',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0(',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0B',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0G',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0C',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0F',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0D',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\08',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0E',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\09',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0F',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\04',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0G',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\07',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0H',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\05',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0I',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\06',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0P',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0Q',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0!',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0R',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0\0p\0€\0\0\0\0\0\0S',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0 ',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0\"',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0%',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0#',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0$',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\00',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\03',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\01',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\02',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0	',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0@',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0C',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0E',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0D',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0A',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0B',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0&',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0)',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0\'',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0(',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\08',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0 ',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\09',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0!',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\04',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0\"',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\07',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0#',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\05',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0$',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\06',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0%',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0&',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0!',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0\'',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0(',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0 ',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\01',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0A',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\09',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\05',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\06',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\01',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\05',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\06',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\01',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0E',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0A',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0S',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0R',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0A',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\01',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0A',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\05',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0	',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0E',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0	',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0D',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0	',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0A',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0	p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0	p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0G',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\01',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0D',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\05',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\01',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\0A',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(_binary '–\Ô\×0p\0€\0\0\0\0\0\0',_binary '–\Ô\×\0p\0€\0\0\0\0\0\0',_binary '–\Ô\× \0p\0€\0\0\0\0\0\05',1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL);
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `pk_role_id` binary(16) NOT NULL,
  `role_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_level` int NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_role_id`),
  UNIQUE KEY `uq_roles_role_name` (`role_name`),
  KEY `idx_roles_is_active` (`is_active`),
  KEY `idx_roles_is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (_binary '–\Ô\×\0p\0€\0\0\0\0\0\0','SUPER_ADMIN','Full unrestricted system owner',100,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(_binary '–\Ô\×\0p\0€\0\0\0\0\0\0','ADMIN','Operational business administrator',90,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(_binary '–\Ô\×\0p\0€\0\0\0\0\0\0','SYSTEM','Internal system role',95,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(_binary '–\Ô\×\0p\0€\0\0\0\0\0\0','SERVICE_ACCOUNT','Background service account role',70,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(_binary '–\Ô\×\0p\0€\0\0\0\0\0\0','API_CLIENT','External API integration role',60,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(_binary '–\Ô\×\0p\0€\0\0\0\0\0\0','EMPLOYEE','Employee role',50,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(_binary '–\Ô\×\0p\0€\0\0\0\0\0\0','STUDENT','Student role',40,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(_binary '–\Ô\×\0p\0€\0\0\0\0\0\0','CLIENT','Client role',30,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(_binary '–\Ô\×\0p\0€\0\0\0\0\0\0	','REPORT_ANALYST','Reporting and analytics role',25,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(_binary '–\Ô\×\0p\0€\0\0\0\0\0\0','AUDITOR','Read-only audit role',20,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(_binary '–\Ô\×\0p\0€\0\0\0\0\0\0','VIEWER','Read-only viewer role',15,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(_binary '–\Ô\×\0p\0€\0\0\0\0\0\0','USER','Default authenticated application user',10,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_status_history`
--

DROP TABLE IF EXISTS `student_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_status_history` (
  `pk_student_status_history_id` binary(16) NOT NULL,
  `fk_student_id` binary(16) NOT NULL,
  `fk_student_status_id` binary(16) NOT NULL,
  `changed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changed_by` binary(16) DEFAULT NULL,
  `remarks` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pk_student_status_history_id`),
  KEY `idx_student_status_history_student_id` (`fk_student_id`),
  KEY `idx_student_status_history_status_id` (`fk_student_status_id`),
  KEY `idx_student_status_history_changed_at` (`changed_at`),
  KEY `idx_student_status_history_student_id_changed_at` (`fk_student_id`,`changed_at`),
  CONSTRAINT `fk_student_status_history_student_id` FOREIGN KEY (`fk_student_id`) REFERENCES `students` (`pk_student_id`),
  CONSTRAINT `fk_student_status_history_student_status_id` FOREIGN KEY (`fk_student_status_id`) REFERENCES `student_statuses` (`pk_student_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_status_history`
--

LOCK TABLES `student_status_history` WRITE;
/*!40000 ALTER TABLE `student_status_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_statuses`
--

DROP TABLE IF EXISTS `student_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_statuses` (
  `pk_student_status_id` binary(16) NOT NULL,
  `status_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_student_status_id`),
  UNIQUE KEY `uq_student_statuses_status_name` (`status_name`),
  KEY `idx_student_statuses_is_active` (`is_active`),
  KEY `idx_student_statuses_is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_statuses`
--

LOCK TABLES `student_statuses` WRITE;
/*!40000 ALTER TABLE `student_statuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `pk_student_id` binary(16) NOT NULL,
  `fk_user_id` binary(16) NOT NULL,
  `fk_department_id` binary(16) NOT NULL,
  `fk_course_id` binary(16) NOT NULL,
  `fk_student_status_id` binary(16) NOT NULL,
  `fk_employee_id` binary(16) DEFAULT NULL,
  `student_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `joining_date` date NOT NULL,
  `academic_year` tinyint DEFAULT NULL,
  `semester` tinyint DEFAULT NULL,
  `passed_out_year` year DEFAULT NULL,
  `cgpa` decimal(5,2) DEFAULT NULL,
  `emergency_contact_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_contact_phone_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line_1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_student_id`),
  UNIQUE KEY `uq_students_user_id` (`fk_user_id`),
  UNIQUE KEY `uq_students_student_code` (`student_code`),
  KEY `idx_students_department_id` (`fk_department_id`),
  KEY `idx_students_course_id` (`fk_course_id`),
  KEY `idx_students_student_status_id` (`fk_student_status_id`),
  KEY `idx_students_employee_id` (`fk_employee_id`),
  KEY `idx_students_is_active` (`is_active`),
  KEY `idx_students_is_deleted` (`is_deleted`),
  KEY `idx_students_joining_date` (`joining_date`),
  KEY `idx_students_department_id_is_active` (`fk_department_id`,`is_active`),
  KEY `idx_students_course_id_is_active` (`fk_course_id`,`is_active`),
  KEY `idx_students_employee_id_is_active` (`fk_employee_id`,`is_active`),
  CONSTRAINT `fk_students_course_id` FOREIGN KEY (`fk_course_id`) REFERENCES `courses` (`pk_course_id`),
  CONSTRAINT `fk_students_department_id` FOREIGN KEY (`fk_department_id`) REFERENCES `departments` (`pk_department_id`),
  CONSTRAINT `fk_students_employee_id` FOREIGN KEY (`fk_employee_id`) REFERENCES `employees` (`pk_employee_id`),
  CONSTRAINT `fk_students_student_status_id` FOREIGN KEY (`fk_student_status_id`) REFERENCES `student_statuses` (`pk_student_status_id`),
  CONSTRAINT `fk_students_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
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
  `comment_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_edited` tinyint(1) NOT NULL DEFAULT '0',
  `edited_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_task_comment_id`),
  KEY `idx_task_comments_task_id` (`fk_task_id`),
  KEY `idx_task_comments_user_id` (`fk_user_id`),
  KEY `idx_task_comments_created_at` (`created_at`),
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
  `priority_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_task_priority_id`),
  UNIQUE KEY `uq_task_priorities_priority_name` (`priority_name`),
  KEY `idx_task_priorities_is_active` (`is_active`)
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
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pk_task_status_history_id`),
  KEY `idx_task_status_history_task_id` (`fk_task_id`),
  KEY `idx_task_status_history_status_id` (`fk_task_status_id`),
  KEY `idx_task_status_history_changed_at` (`changed_at`),
  KEY `idx_task_status_history_task_id_changed_at` (`fk_task_id`,`changed_at`),
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
  `status_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_task_status_id`),
  UNIQUE KEY `uq_task_statuses_status_name` (`status_name`),
  KEY `idx_task_statuses_is_active` (`is_active`)
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
  `fk_user_id` binary(16) NOT NULL,
  `fk_task_status_id` binary(16) NOT NULL,
  `fk_task_priority_id` binary(16) NOT NULL,
  `task_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `task_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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
  KEY `idx_tasks_project_id` (`fk_project_id`),
  KEY `idx_tasks_task_status_id` (`fk_task_status_id`),
  KEY `idx_tasks_task_priority_id` (`fk_task_priority_id`),
  KEY `idx_tasks_deadline_at` (`deadline_at`),
  KEY `idx_tasks_completed_at` (`completed_at`),
  KEY `idx_tasks_is_active` (`is_active`),
  KEY `idx_tasks_is_deleted` (`is_deleted`),
  KEY `idx_tasks_project_status` (`fk_project_id`,`fk_task_status_id`),
  KEY `idx_tasks_project_priority` (`fk_project_id`,`fk_task_priority_id`),
  KEY `idx_tasks_user_id` (`fk_user_id`),
  KEY `idx_tasks_user_deadline` (`fk_user_id`,`deadline_at`),
  KEY `idx_tasks_user_id_status_id` (`fk_user_id`,`fk_task_status_id`),
  CONSTRAINT `fk_tasks_project_id` FOREIGN KEY (`fk_project_id`) REFERENCES `projects` (`pk_project_id`),
  CONSTRAINT `fk_tasks_task_priority_id` FOREIGN KEY (`fk_task_priority_id`) REFERENCES `task_priorities` (`pk_task_priority_id`),
  CONSTRAINT `fk_tasks_task_status_id` FOREIGN KEY (`fk_task_status_id`) REFERENCES `task_statuses` (`pk_task_status_id`),
  CONSTRAINT `fk_tasks_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`)
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
  `refresh_token_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `refresh_token_expires_at` timestamp NOT NULL,
  `revoked_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pk_user_session_id`),
  KEY `idx_user_sessions_user_id` (`fk_user_id`),
  KEY `idx_user_sessions_refresh_token_expires_at` (`refresh_token_expires_at`),
  KEY `idx_user_sessions_refresh_lookup` (`refresh_token_hash`,`is_active`,`revoked_at`,`refresh_token_expires_at`),
  KEY `idx_user_sessions_user_id_is_active` (`fk_user_id`,`is_active`),
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
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `is_email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_user_id`),
  UNIQUE KEY `uq_users_username` (`username`),
  UNIQUE KEY `uq_users_email` (`email`),
  KEY `idx_users_role_id` (`fk_role_id`),
  KEY `idx_users_is_active` (`is_active`),
  KEY `idx_users_is_deleted` (`is_deleted`),
  KEY `idx_users_is_locked` (`is_locked`),
  KEY `idx_users_last_login_at` (`last_login_at`),
  KEY `idx_users_email_is_active` (`email`,`is_active`),
  KEY `idx_users_username_is_active` (`username`,`is_active`),
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
/*!50003 DROP PROCEDURE IF EXISTS `001_sp_auth_register_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `001_sp_auth_register_user`(
    IN p_user_id BINARY(16),
    IN p_email_verification_token_id BINARY(16),

    IN p_username VARCHAR(100),
    IN p_email VARCHAR(255),

    IN p_password_hash VARCHAR(255),

    IN p_role_name VARCHAR(100),

    IN p_verification_token_hash VARCHAR(255),
    IN p_verification_token_expires_at TIMESTAMP
)
BEGIN

    /*
    ===========================================================================
    VARIABLES
    ===========================================================================
    */

    DECLARE v_user_id BINARY(16);
    DECLARE v_email_verification_token_id BINARY(16);

    DECLARE v_username VARCHAR(100);
    DECLARE v_email VARCHAR(255);

    DECLARE v_password_hash VARCHAR(255);

    DECLARE v_role_name VARCHAR(100);
    DECLARE v_role_id BINARY(16);

    DECLARE v_verification_token_hash VARCHAR(255);
    DECLARE v_verification_token_expires_at TIMESTAMP;

    DECLARE v_row_count INT DEFAULT 0;

    /*
    ===========================================================================
    ERROR HANDLER
    ===========================================================================
    */

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN

        GET DIAGNOSTICS CONDITION 1
            @p1 = MESSAGE_TEXT;

        ROLLBACK;

        DROP TEMPORARY TABLE IF EXISTS tmp_role_lookup;
        DROP TEMPORARY TABLE IF EXISTS tmp_existing_user;
        DROP TEMPORARY TABLE IF EXISTS tmp_inserted_user;
        DROP TEMPORARY TABLE IF EXISTS tmp_register_result;

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = @p1;

    END;

    /*
    ===========================================================================
    NORMALIZE INPUT
    ===========================================================================
    */

    SET v_user_id = p_user_id;

    SET v_email_verification_token_id =
        p_email_verification_token_id;

    SET v_username =
        TRIM(LOWER(p_username));

    SET v_email =
        TRIM(LOWER(p_email));

    SET v_password_hash =
        TRIM(p_password_hash);

    SET v_role_name =
        TRIM(UPPER(p_role_name));

    SET v_verification_token_hash =
        TRIM(p_verification_token_hash);

    SET v_verification_token_expires_at =
        p_verification_token_expires_at;

    /*
    ===========================================================================
    START TRANSACTION
    ===========================================================================
    */

    START TRANSACTION;

    /*
    ===========================================================================
    DROP TEMP TABLES IF EXIST
    ===========================================================================
    */

    DROP TEMPORARY TABLE IF EXISTS tmp_role_lookup;
    DROP TEMPORARY TABLE IF EXISTS tmp_existing_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_inserted_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_enriched_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_register_result;

    /*
    ===========================================================================
    CREATE TEMP TABLES
    ===========================================================================
    */

    CREATE TEMPORARY TABLE tmp_role_lookup
    (
        pk_role_id BINARY(16),

        role_name VARCHAR(100),

        is_active BOOLEAN,
        is_deleted BOOLEAN
    );

    CREATE TEMPORARY TABLE tmp_existing_user
    (
        pk_user_id BINARY(16),

        username VARCHAR(100),
        email VARCHAR(255)
    );

    CREATE TEMPORARY TABLE tmp_inserted_user
    (
        pk_user_id BINARY(16),
        fk_role_id BINARY(16),

        username VARCHAR(100),
        email VARCHAR(255),

        is_email_verified BOOLEAN,
        is_active BOOLEAN,

        created_at TIMESTAMP
    );
    
	CREATE TEMPORARY TABLE tmp_enriched_user
    (
        user_id CHAR(36),
        role_id CHAR(36),

        username VARCHAR(100),
        email VARCHAR(255),

        role_name VARCHAR(100),

        is_email_verified BOOLEAN,
        is_active BOOLEAN,

        created_at TIMESTAMP
    );

    CREATE TEMPORARY TABLE tmp_register_result
    (
        user_id CHAR(36),
        role_id CHAR(36),

        username VARCHAR(100),
        email VARCHAR(255),

        role_name VARCHAR(100),

        is_email_verified BOOLEAN,
        is_active BOOLEAN,

        created_at TIMESTAMP
    );

    /*
    ===========================================================================
    VALIDATE INPUTS
    ===========================================================================
    */

	/*
	===========================================================================
	VALIDATE USERNAME
	===========================================================================

	Purpose :
		Ensures username input is present after normalization.
	*/

	IF v_username IS NULL
	OR v_username = '' THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Invalid username';

	END IF;

	/*
	===========================================================================
	VALIDATE EMAIL
	===========================================================================

	Purpose :
		Ensures email input is present after normalization.
	*/

	IF v_email IS NULL
	OR v_email = '' THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Invalid email address';

	END IF;

	/*
	===========================================================================
	VALIDATE PASSWORD HASH
	===========================================================================

	Purpose :
		Ensures backend-generated password hash exists.
	*/

	IF v_password_hash IS NULL
	OR v_password_hash = '' THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Invalid password hash';

	END IF;

	/*
	===========================================================================
	VALIDATE ROLE NAME
	===========================================================================

	Purpose :
		Ensures requested role name exists as input.
	*/

	IF v_role_name IS NULL
	OR v_role_name = '' THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'User role not found';

	END IF;

	/*
	===========================================================================
	VALIDATE VERIFICATION TOKEN HASH
	===========================================================================

	Purpose :
		Ensures verification token hash exists.
	*/

	IF v_verification_token_hash IS NULL
	OR v_verification_token_hash = '' THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Verification token invalid';

	END IF;

	/*
	===========================================================================
	VALIDATE VERIFICATION TOKEN EXPIRY
	===========================================================================

	Purpose :
		Ensures verification token expiry timestamp exists.
	*/

	IF v_verification_token_expires_at IS NULL THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Verification token invalid';

	END IF;

	/*
	===========================================================================
	FETCH ROLE
	===========================================================================

	Purpose :
		Fetches requested role information for validation and inserts it into
		temporary lookup table.
	*/

	INSERT INTO tmp_role_lookup
	(
		pk_role_id,

		role_name,

		is_active,
		is_deleted
	)
	SELECT
		r.pk_role_id,

		r.role_name,

		r.is_active,
		r.is_deleted
	FROM roles r
	WHERE UPPER(r.role_name) = v_role_name
	LIMIT 1;

    /*
    ===========================================================================
    VALIDATE ROLE
    ===========================================================================
    */

	/*
	===========================================================================
	VALIDATE ROLE EXISTS
	===========================================================================

	Purpose :
		Ensures requested role exists in roles table.
	*/

	SELECT COUNT(*)
	INTO v_row_count
	FROM tmp_role_lookup;

	IF v_row_count = 0 THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'User role not found';

	END IF;

	/*
	===========================================================================
	VALIDATE ROLE ACTIVE
	===========================================================================

	Purpose :
		Prevents registration using inactive roles.
	*/

	IF EXISTS
	(
		SELECT 1
		FROM tmp_role_lookup
		WHERE is_active = FALSE
	)
	THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'User role inactive';

	END IF;

	/*
	===========================================================================
	VALIDATE ROLE DELETED
	===========================================================================

	Purpose :
		Prevents registration using deleted roles.
	*/

	IF EXISTS
	(
		SELECT 1
		FROM tmp_role_lookup
		WHERE is_deleted = TRUE
	)
	THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'User role deleted';

	END IF;

	/*
	===========================================================================
	SET ROLE ID
	===========================================================================

	Purpose :
		Stores validated role UUID into variable for inserts.
	*/

	SELECT pk_role_id
	INTO v_role_id
	FROM tmp_role_lookup
	LIMIT 1;
    
	/*
	===========================================================================
	VALIDATE USERNAME UNIQUENESS
	===========================================================================

	Purpose :
		Ensures username is not already used by another account.
	*/

	/*
	===========================================================================
	FETCH EXISTING USERNAME
	===========================================================================
	*/

	INSERT INTO tmp_existing_user
	(
		pk_user_id,
		username,
		email
	)
	SELECT
		u.pk_user_id,
		u.username,
		u.email
	FROM users u
	WHERE LOWER(u.username) = v_username
	LIMIT 1;

	/*
	===========================================================================
	VALIDATE USERNAME EXISTS
	===========================================================================
	*/

	IF EXISTS
	(
		SELECT 1
		FROM tmp_existing_user
	)
	THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Username already exists';

	END IF;

	/*
	===========================================================================
	VALIDATE EMAIL UNIQUENESS
	===========================================================================

	Purpose :
		Ensures email address is not already used by another account.
	*/

	/*
	===========================================================================
	FETCH EXISTING EMAIL
	===========================================================================
	*/

	INSERT INTO tmp_existing_user
	(
		pk_user_id,
		username,
		email
	)
	SELECT
		u.pk_user_id,
		u.username,
		u.email
	FROM users u
	WHERE LOWER(u.email) = v_email
	LIMIT 1;

	/*
	===========================================================================
	VALIDATE EMAIL EXISTS
	===========================================================================
	*/

	IF EXISTS
	(
		SELECT 1
		FROM tmp_existing_user
		WHERE email = v_email
	)
	THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Email address already exists';

	END IF;

	/*
	===========================================================================
	INSERT USER
	===========================================================================

	Purpose :
		Inserts newly registered user account into users table.
	*/

	/*
	===========================================================================
	INSERT USER RECORD
	===========================================================================
	*/

	INSERT INTO users
	(
		pk_user_id,
		fk_role_id,

		username,
		email,

		password_hash,

		is_email_verified,

		is_locked,
		locked_at,

		last_login_at,

		is_active,

		is_deleted,
		deleted_at,

		created_at,
		created_by,

		updated_at,
		updated_by
	)
	VALUES
	(
		v_user_id,
		v_role_id,

		v_username,
		v_email,

		v_password_hash,

		FALSE,

		FALSE,
		NULL,

		NULL,

		TRUE,

		FALSE,
		NULL,

		CURRENT_TIMESTAMP,
		NULL,

		CURRENT_TIMESTAMP,
		NULL
	);

	/*
	===========================================================================
	STORE INSERTED USER
	===========================================================================

	Purpose :
		Stores inserted user data into temporary table for enrichment and final
		response generation.
	*/

	INSERT INTO tmp_inserted_user
	(
		pk_user_id,
		fk_role_id,

		username,
		email,

		is_email_verified,
		is_active,

		created_at
	)
	SELECT
		u.pk_user_id,
		u.fk_role_id,

		u.username,
		u.email,

		u.is_email_verified,
		u.is_active,

		u.created_at
	FROM users u
	WHERE u.pk_user_id = v_user_id
	LIMIT 1;

	/*
	===========================================================================
	REVOKE OLD EMAIL VERIFICATION TOKENS
	===========================================================================

	Purpose :
		Revokes previously active email verification tokens before inserting
		new verification token.
	*/

	/*
	===========================================================================
	REVOKE ACTIVE TOKENS
	===========================================================================
	*/

	UPDATE email_verification_tokens
	SET
		is_active = FALSE
	WHERE fk_user_id = v_user_id
	AND is_active = TRUE;

	/*
	===========================================================================
	INSERT EMAIL VERIFICATION TOKEN
	===========================================================================

	Purpose :
		Inserts newly generated email verification token for registered user.
	*/

	/*
	===========================================================================
	INSERT EMAIL VERIFICATION TOKEN RECORD
	===========================================================================
	*/

	INSERT INTO email_verification_tokens
	(
		pk_email_verification_token_id,
		fk_user_id,

		verification_token_hash,

		expires_at,
		verified_at,

		is_active,

		created_at
	)
	VALUES
	(
		v_email_verification_token_id,
		v_user_id,

		v_verification_token_hash,

		v_verification_token_expires_at,
		NULL,

		TRUE,

		CURRENT_TIMESTAMP
	);

	/*
	===========================================================================
	ENRICH REGISTERED USER
	===========================================================================

	Purpose :
		Enriches inserted user data with role information for final response.
	*/

	/*
	===========================================================================
	CREATE ENRICHED USER CTE
	===========================================================================
	*/
    
	INSERT INTO tmp_enriched_user
	(
		user_id,
		role_id,

		username,
		email,

		role_name,

		is_email_verified,
		is_active,

		created_at
	)
	WITH cte_enriched_user AS
	(
		SELECT
			u.pk_user_id,
			u.fk_role_id,

			u.username,
			u.email,

			r.role_name,

			u.is_email_verified,
			u.is_active,

			u.created_at
		FROM tmp_inserted_user u
		INNER JOIN roles r
			ON r.pk_role_id = u.fk_role_id
	)
	SELECT
		BIN_TO_UUID(pk_user_id, TRUE),
		BIN_TO_UUID(fk_role_id, TRUE),

		username,
		email,

		role_name,

		is_email_verified,
		is_active,

		created_at
	FROM cte_enriched_user;

    /*
    ===========================================================================
    INSERT FINAL RESULT
    ===========================================================================
    */
    
	INSERT INTO tmp_register_result
	(
		user_id,
		role_id,

		username,
		email,

		role_name,

		is_email_verified,
		is_active,

		created_at
	)
	SELECT
		user_id,
		role_id,

		username,
		email,

		role_name,

		is_email_verified,
		is_active,

		created_at
	FROM tmp_enriched_user;
    
	/*
	===========================================================================
	RETURN RESULT
	===========================================================================

	Purpose :
		Returns final enriched registered user result set to backend.
	*/

	SELECT
		user_id,
		role_id,

		username,
		email,

		role_name,

		is_email_verified,
		is_active,

		created_at
	FROM tmp_register_result;

    /*
    ===========================================================================
    CLEANUP
    ===========================================================================
    */

    DROP TEMPORARY TABLE IF EXISTS tmp_role_lookup;
    DROP TEMPORARY TABLE IF EXISTS tmp_existing_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_inserted_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_enriched_user;
    DROP TEMPORARY TABLE IF EXISTS tmp_register_result;

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-15 12:43:55

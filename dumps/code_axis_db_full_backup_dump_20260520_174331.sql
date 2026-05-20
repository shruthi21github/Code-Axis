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
-- Drop if exists Current Database: `code_axis_db`
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
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
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
  `course_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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
INSERT INTO `departments` VALUES (0x79042219535411F18D98B05CDA617960,'Engineering',NULL,1,0,NULL,'2026-05-19 07:29:29',NULL,'2026-05-19 07:29:29',NULL);
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
INSERT INTO `designations` VALUES (0x79068B7B535411F18D98B05CDA617960,'Backend Developer',NULL,1,0,NULL,'2026-05-19 07:29:29',NULL,'2026-05-19 07:29:29',NULL);
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
  `unit_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `email_verification_tokens` VALUES (0x019E2A9C4A2677319748268BEC19F837,0x019E2A9C494F767283AD7029368DC96F,'d0af5c3a8c5b8bd100b0264b8166c9167a33f38e2fe41e36345c7e7dffc70af4','2026-05-16 07:49:06',NULL,1,'2026-05-15 07:49:06'),(0x019E2AC268007602AD7958379AC2FE93,0x019E2AC26759756BA87E790E7D2EB1C7,'2019112c3e4de40e4d9b08eede58aee93dd287bcba8b659e043f9ec2e88af0bf','2026-05-16 08:30:44',NULL,1,'2026-05-15 08:30:44'),(0x019E2B00DBAD7A3BAD3774E71D9D2BF3,0x019E2B00DADB70F39A41D405BEF6DCD2,'0bdf8dd7d49aad3e5ee726e49d17b540235698ce99270ec8d84ed94738381893','2026-05-16 09:38:57',NULL,1,'2026-05-15 09:38:57'),(0x019E301A0F6A73A8A561E759BA338482,0x019E301A0E887A6AA1FB389F03B64D5D,'73f3177c4a75a12ed513f7331b41cf448b4c9e781c5afc9ed59efd5dd693da43','2026-05-17 09:24:35','2026-05-16 09:28:11',0,'2026-05-16 09:24:35'),(0x019E310A881A7572B338E87ADCAAF2C0,0x019E310A874B7CF0BECFB41CD7635EFB,'3e6bc3d2689512611008e633a05a355d1c76dcebf7b5b4022929be40f5047cf6','2026-05-17 13:47:14','2026-05-16 13:57:18',0,'2026-05-16 13:47:14'),(0x019E39BB87E9745787B072B48AF6C871,0x019E39BB863F718DACDE8E499BF5F95D,'a6e7373df559c65136926ac998e645c9e0390cd3fffe54bee9b9b723fddd0386','2026-05-19 06:17:32','2026-05-18 06:22:42',0,'2026-05-18 06:17:32'),(0x019E3A10EEBD7AFF9F0B1FBB227F1E3A,0x019E3A10EDA2714089D1F18826EEC8CD,'76152fb9dc96302a9908c620fa8c46455b94436b3dc66abf62b459fbbcfa2dfa','2026-05-19 07:50:49',NULL,1,'2026-05-18 07:50:49'),(0x019E3A1505AC79DF8EBFB58E357E941F,0x019E3A1504E278438AAC506877CA8DD4,'dc51c77e0ba36ff7de10ba6c282c67658352b46087e92deb42ad25e5e01e364c','2026-05-19 07:55:17','2026-05-18 07:55:58',0,'2026-05-18 07:55:17'),(0x019E3A5D55A378778AFCE2B2A10C7DA8,0x019E3A5D53887C03939E74C95827622D,'ecdf633a502724d6b388f9fb7e2c20008605da695ab2c0ead2b843d42e389d0c','2026-05-19 09:14:16','2026-05-18 09:14:52',0,'2026-05-18 09:14:16'),(0x019E3AF93512793999A099ABB85044FB,0x019E3AF933297781B6DF31455E038815,'438eead5ad32b1d4b83be1edf7149f3eb58b430735cf6cccdfcc7031865f4151','2026-05-19 12:04:31','2026-05-18 12:05:12',0,'2026-05-18 12:04:31'),(0x019E3B79E8B174D3BA1011E57EA1AFE1,0x019E3B79E68F7443941DD9B336E7CAE0,'fe6762a4f0acefe8e3bb13f9918496b267f105541e879f4a9ebcc67b0db75670','2026-05-19 14:25:06','2026-05-18 14:25:41',0,'2026-05-18 14:25:06');
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
INSERT INTO `employees` VALUES (0xA64B9E80535411F18D98B05CDA617960,0x019E3B79E68F7443941DD9B336E7CAE0,0x79042219535411F18D98B05CDA617960,0x79068B7B535411F18D98B05CDA617960,NULL,'EMP-001','Rohan','F',NULL,'2026-01-01',NULL,1,0,NULL,'2026-05-19 07:30:45',NULL,'2026-05-19 07:30:45',NULL);
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
  `module_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `permissions` VALUES (0x0196D4D7200070008000000000000001,'auth','login','auth.login','Login permission',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000002,'auth','logout','auth.logout','Logout permission',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000003,'auth','refresh_token','auth.refresh_token','Refresh token permission',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000004,'auth','verify_email','auth.verify_email','Verify email permission',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000005,'auth','reset_password','auth.reset_password','Reset password permission',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000006,'roles','create','roles.create','Create roles',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000007,'roles','read','roles.read','Read roles',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000008,'roles','update','roles.update','Update roles',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000009,'roles','delete','roles.delete','Delete roles',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000010,'permissions','create','permissions.create','Create permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000011,'permissions','read','permissions.read','Read permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000012,'permissions','update','permissions.update','Update permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000013,'permissions','delete','permissions.delete','Delete permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000014,'role_permissions','create','role_permissions.create','Create role permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000015,'role_permissions','read','role_permissions.read','Read role permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000016,'role_permissions','update','role_permissions.update','Update role permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000017,'role_permissions','delete','role_permissions.delete','Delete role permissions',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000018,'users','create','users.create','Create users',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000019,'users','read','users.read','Read users',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000020,'users','update','users.update','Update users',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000021,'users','delete','users.delete','Delete users',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000022,'employees','create','employees.create','Create employees',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000023,'employees','read','employees.read','Read employees',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000024,'employees','update','employees.update','Update employees',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000025,'employees','delete','employees.delete','Delete employees',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000026,'students','create','students.create','Create students',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000027,'students','read','students.read','Read students',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000028,'students','update','students.update','Update students',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000029,'students','delete','students.delete','Delete students',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000030,'projects','create','projects.create','Create projects',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000031,'projects','read','projects.read','Read projects',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000032,'projects','update','projects.update','Update projects',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000033,'projects','delete','projects.delete','Delete projects',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000034,'tasks','create','tasks.create','Create tasks',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000035,'tasks','read','tasks.read','Read tasks',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000036,'tasks','update','tasks.update','Update tasks',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000037,'tasks','delete','tasks.delete','Delete tasks',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000038,'tasks','assign','tasks.assign','Assign tasks',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000039,'tasks','complete','tasks.complete','Complete tasks',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000040,'reports','create','reports.create','Create reports',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000041,'reports','read','reports.read','Read reports',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000042,'reports','update','reports.update','Update reports',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000043,'reports','delete','reports.delete','Delete reports',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000044,'reports','export','reports.export','Export reports',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000045,'reports','download','reports.download','Download reports',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000046,'system','settings_update','system.settings_update','Update system settings',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000047,'system','health_check','system.health_check','System health check',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000048,'database','backup','database.backup','Backup database',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000049,'database','restore','database.restore','Restore database',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000050,'seeddata','execute','seeddata.execute','Execute seed data',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000051,'migration','execute','migration.execute','Execute migrations',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000052,'indexes','verify','indexes.verify','Verify indexes',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL),(0x0196D4D7200070008000000000000053,'audit_logs','read','audit_logs.read','Read audit logs',1,0,NULL,'2026-05-15 05:47:15',NULL,'2026-05-15 05:47:15',NULL);
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
INSERT INTO `project_statuses` VALUES (0x78D89F41535411F18D98B05CDA617960,'PLANNING','Project is in planning phase',1,0,NULL,'2026-05-19 07:29:29',NULL,'2026-05-19 07:29:29',NULL);
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
INSERT INTO `projects` VALUES (0x9490FF1E24974AF88C7B708C1546519A,0x78D89F41535411F18D98B05CDA617960,'PROJ-003','Code Axis Backend v3','Spring Boot backend development','2026-05-15 03:30:00','2026-08-31 12:30:00',1,0,NULL,'2026-05-19 07:31:02',NULL,'2026-05-19 07:31:02',NULL),(0xB8C05E7C263E487C80D398BEF6FD6C9D,0x78D89F41535411F18D98B05CDA617960,'PROJ-005','Code Axis Backend v3','Spring Boot backend development','2026-05-15 03:30:00','2026-08-31 12:30:00',1,0,NULL,'2026-05-19 07:32:00',NULL,'2026-05-19 07:32:00',NULL);
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
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT NULL,
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
INSERT INTO `role_permissions` VALUES (0x0196D4D7300070008000000000000001,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000053,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000002,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000001,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000003,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000002,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000004,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000003,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000005,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000005,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000006,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000004,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000007,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000048,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000008,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000049,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000009,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000022,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000010,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000025,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000011,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000023,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000012,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000024,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000013,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000052,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000014,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000051,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000015,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000010,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000016,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000013,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000017,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000011,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000018,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000012,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000019,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000030,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000020,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000033,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000021,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000031,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000022,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000032,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000023,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000040,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000024,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000043,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000025,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000045,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000026,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000044,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000027,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000041,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000028,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000042,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000029,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000014,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000030,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000017,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000031,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000015,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000032,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000016,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000033,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000006,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000034,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000009,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000035,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000007,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000036,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000008,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000037,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000050,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000038,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000026,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000039,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000029,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000040,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000027,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000041,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000028,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000042,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000047,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000043,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000046,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000044,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000038,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000045,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000039,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000046,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000034,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000047,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000037,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000048,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000035,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000049,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000036,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000050,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000018,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000051,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000021,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000052,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000019,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300070008000000000000053,0x0196D4D7100070008000000000000001,0x0196D4D7200070008000000000000020,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000001,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000022,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000002,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000025,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000003,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000023,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000004,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000024,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000005,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000030,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000006,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000033,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000007,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000031,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000008,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000032,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000009,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000040,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000010,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000043,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000011,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000045,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000012,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000044,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000013,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000041,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000014,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000042,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000015,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000026,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000016,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000029,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000017,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000027,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000018,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000028,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000019,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000038,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000020,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000039,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000021,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000034,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000022,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000037,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000023,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000035,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000024,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000036,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000025,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000018,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000026,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000021,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000027,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000019,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300170008000000000000028,0x0196D4D7100070008000000000000002,0x0196D4D7200070008000000000000020,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300270008000000000000001,0x0196D4D7100070008000000000000006,0x0196D4D7200070008000000000000031,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300270008000000000000002,0x0196D4D7100070008000000000000006,0x0196D4D7200070008000000000000041,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300270008000000000000003,0x0196D4D7100070008000000000000006,0x0196D4D7200070008000000000000039,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300270008000000000000004,0x0196D4D7100070008000000000000006,0x0196D4D7200070008000000000000035,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300270008000000000000005,0x0196D4D7100070008000000000000006,0x0196D4D7200070008000000000000036,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300370008000000000000001,0x0196D4D7100070008000000000000007,0x0196D4D7200070008000000000000031,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300370008000000000000002,0x0196D4D7100070008000000000000007,0x0196D4D7200070008000000000000035,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300370008000000000000003,0x0196D4D7100070008000000000000007,0x0196D4D7200070008000000000000036,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300470008000000000000001,0x0196D4D7100070008000000000000008,0x0196D4D7200070008000000000000031,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300470008000000000000002,0x0196D4D7100070008000000000000008,0x0196D4D7200070008000000000000045,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300470008000000000000003,0x0196D4D7100070008000000000000008,0x0196D4D7200070008000000000000041,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300570008000000000000001,0x0196D4D7100070008000000000000012,0x0196D4D7200070008000000000000001,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300570008000000000000002,0x0196D4D7100070008000000000000012,0x0196D4D7200070008000000000000002,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300570008000000000000003,0x0196D4D7100070008000000000000012,0x0196D4D7200070008000000000000003,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300570008000000000000004,0x0196D4D7100070008000000000000012,0x0196D4D7200070008000000000000004,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300670008000000000000001,0x0196D4D7100070008000000000000010,0x0196D4D7200070008000000000000053,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300670008000000000000002,0x0196D4D7100070008000000000000010,0x0196D4D7200070008000000000000052,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300670008000000000000003,0x0196D4D7100070008000000000000010,0x0196D4D7200070008000000000000041,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300770008000000000000001,0x0196D4D7100070008000000000000011,0x0196D4D7200070008000000000000031,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300770008000000000000002,0x0196D4D7100070008000000000000011,0x0196D4D7200070008000000000000041,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300770008000000000000003,0x0196D4D7100070008000000000000011,0x0196D4D7200070008000000000000035,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300870008000000000000001,0x0196D4D7100070008000000000000009,0x0196D4D7200070008000000000000045,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300870008000000000000002,0x0196D4D7100070008000000000000009,0x0196D4D7200070008000000000000044,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300870008000000000000003,0x0196D4D7100070008000000000000009,0x0196D4D7200070008000000000000041,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300970008000000000000001,0x0196D4D7100070008000000000000003,0x0196D4D7200070008000000000000003,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7300970008000000000000002,0x0196D4D7100070008000000000000003,0x0196D4D7200070008000000000000047,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7301070008000000000000001,0x0196D4D7100070008000000000000004,0x0196D4D7200070008000000000000031,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7301070008000000000000002,0x0196D4D7100070008000000000000004,0x0196D4D7200070008000000000000044,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7301070008000000000000003,0x0196D4D7100070008000000000000004,0x0196D4D7200070008000000000000035,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7301170008000000000000001,0x0196D4D7100070008000000000000005,0x0196D4D7200070008000000000000031,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7301170008000000000000002,0x0196D4D7100070008000000000000005,0x0196D4D7200070008000000000000041,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL),(0x0196D4D7301170008000000000000003,0x0196D4D7100070008000000000000005,0x0196D4D7200070008000000000000035,1,0,NULL,'2026-05-15 06:07:29',NULL,'2026-05-15 06:07:29',NULL);
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
INSERT INTO `roles` VALUES (0x0196D4D7100070008000000000000001,'SUPER_ADMIN','Full unrestricted system owner',100,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(0x0196D4D7100070008000000000000002,'ADMIN','Operational business administrator',90,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(0x0196D4D7100070008000000000000003,'SYSTEM','Internal system role',95,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(0x0196D4D7100070008000000000000004,'SERVICE_ACCOUNT','Background service account role',70,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(0x0196D4D7100070008000000000000005,'API_CLIENT','External API integration role',60,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(0x0196D4D7100070008000000000000006,'EMPLOYEE','Employee role',50,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(0x0196D4D7100070008000000000000007,'STUDENT','Student role',40,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(0x0196D4D7100070008000000000000008,'CLIENT','Client role',30,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(0x0196D4D7100070008000000000000009,'REPORT_ANALYST','Reporting and analytics role',25,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(0x0196D4D7100070008000000000000010,'AUDITOR','Read-only audit role',20,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(0x0196D4D7100070008000000000000011,'VIEWER','Read-only viewer role',15,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL),(0x0196D4D7100070008000000000000012,'USER','Default authenticated application user',10,1,0,NULL,'2026-05-15 05:29:53',NULL,'2026-05-15 05:29:53',NULL);
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
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `status_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `student_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `joining_date` date NOT NULL,
  `academic_year` tinyint DEFAULT NULL,
  `semester` tinyint DEFAULT NULL,
  `passed_out_year` year DEFAULT NULL,
  `cgpa` decimal(5,2) DEFAULT NULL,
  `emergency_contact_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_contact_phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `task_priorities` VALUES (0x575C4C24535511F18D98B05CDA617960,'MEDIUM',NULL,1,0,NULL,'2026-05-19 07:35:42',NULL,'2026-05-19 07:35:42',NULL),(0x575F1590535511F18D98B05CDA617960,'LOW',NULL,1,0,NULL,'2026-05-19 07:35:42',NULL,'2026-05-19 07:35:42',NULL),(0x78E60104535411F18D98B05CDA617960,'HIGH',NULL,1,0,NULL,'2026-05-19 07:29:29',NULL,'2026-05-19 07:29:29',NULL);
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
INSERT INTO `task_status_history` VALUES (0x47A6FC4954D54911A5AA0689A4A3F0B5,0xB7EF25FF535511F18D98B05CDA617960,0x78DF8635535411F18D98B05CDA617960,'2026-05-19 07:41:04',NULL,'Started working on task');
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
INSERT INTO `task_statuses` VALUES (0x4756D5D3535511F18D98B05CDA617960,'BLOCKED',NULL,1,0,NULL,'2026-05-19 07:35:15',NULL,'2026-05-19 07:35:15',NULL),(0x78DE4CB3535411F18D98B05CDA617960,'TODO',NULL,1,0,NULL,'2026-05-19 07:29:29',NULL,'2026-05-19 07:29:29',NULL),(0x78DF8635535411F18D98B05CDA617960,'IN_PROGRESS',NULL,1,0,NULL,'2026-05-19 07:29:29',NULL,'2026-05-19 07:29:29',NULL),(0x78E0CE58535411F18D98B05CDA617960,'DONE',NULL,1,0,NULL,'2026-05-19 07:29:29',NULL,'2026-05-19 07:29:29',NULL);
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
INSERT INTO `tasks` VALUES (0xB7EF25FF535511F18D98B05CDA617960,0x9490FF1E24974AF88C7B708C1546519A,0x019E2A9C494F767283AD7029368DC96F,0x78DF8635535411F18D98B05CDA617960,0x78E60104535411F18D98B05CDA617960,'Implement Login API',NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,'2026-05-19 07:38:24',NULL,'2026-05-19 07:38:24',NULL);
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
INSERT INTO `user_sessions` VALUES (0x019E30E0B6CC716591AB84568650DB12,0x019E301A0E887A6AA1FB389F03B64D5D,'0561011826e5d5234b6d56d1c6032aea904c11bd2c115241220e050d23e9433e','2026-05-17 13:01:34',NULL,1,'2026-05-16 13:01:34',0x019E301A0E887A6AA1FB389F03B64D5D),(0x019E3119279D7B789C562D6ED8760BA5,0x019E310A874B7CF0BECFB41CD7635EFB,'98566c27e394b1cdc65b94171f83b9e77b6953f7c241fd56d964b310badaaa4a','2026-05-17 14:03:12',NULL,1,'2026-05-16 14:03:13',0x019E310A874B7CF0BECFB41CD7635EFB),(0x019E39C435977FC19F256451560DF09C,0x019E39BB863F718DACDE8E499BF5F95D,'5bdb41f84387623b0e2290cd9fe079206d8d671286400669b1c19d57cfbbd6c4','2026-05-19 06:27:01',NULL,1,'2026-05-18 06:27:01',0x019E39BB863F718DACDE8E499BF5F95D),(0x019E3A5E07917BC0866AFF3DD99B8FD6,0x019E3A5D53887C03939E74C95827622D,'e758e57a09b093ee954c534288e8c372f0aebdce08aeea58badefc8c605a52ec','2026-05-19 09:15:01',NULL,1,'2026-05-18 09:15:01',0x019E3A5D53887C03939E74C95827622D),(0x019E3AFA489773739E3888D8F0DF1430,0x019E3AF933297781B6DF31455E038815,'8b4bef7f4130418827fd7bc56fb1c1fe76b32de5c4b43c38659d7622e8c75aa5','2026-05-19 12:05:42',NULL,1,'2026-05-18 12:05:42',0x019E3AF933297781B6DF31455E038815),(0x019E3B7A89217837BCD931FE8E466ACB,0x019E3B79E68F7443941DD9B336E7CAE0,'82ee022ff4ebe23553d78bdf7aa4fe19aa0f687e9ea91045ecfe4de818c46072','2026-05-19 14:25:47',NULL,1,'2026-05-18 14:25:47',0x019E3B79E68F7443941DD9B336E7CAE0),(0x019E3EF5B9C17A308A02D2994804F56C,0x019E3B79E68F7443941DD9B336E7CAE0,'ea38dddd6dfd6a5a3fba9de2f8517abc9401db46079e0485cc725242e7f4bf95','2026-05-20 06:39:12',NULL,1,'2026-05-19 06:39:12',0x019E3B79E68F7443941DD9B336E7CAE0),(0x019E3F00E57F7518A618A769B42BE201,0x019E3B79E68F7443941DD9B336E7CAE0,'da4b11543e3c8fbbdc3d1368f4e9edef08a04201195e075a7a67c43054193c3f','2026-05-20 06:51:24',NULL,1,'2026-05-19 06:51:24',0x019E3B79E68F7443941DD9B336E7CAE0),(0x019E3F05E538789D82DFC3C8B6371BFD,0x019E3B79E68F7443941DD9B336E7CAE0,'f7e45a13d1d73c05f75183f2ce18bd264b43a06ad46f5150240a765fcfc0590e','2026-05-20 06:56:51',NULL,1,'2026-05-19 06:56:52',0x019E3B79E68F7443941DD9B336E7CAE0);
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
INSERT INTO `users` VALUES (0x019E2A9C494F767283AD7029368DC96F,0x0196D4D7100070008000000000000012,'rajamouli','rajamouli@test.com',NULL,'$2a$10$A0T3WKRO2KlDVYD.N0wioOwUivIqEiyKQHgOJqNjB4LBQxteOzFSu',0,NULL,NULL,1,0,NULL,'2026-05-15 07:49:06',NULL,'2026-05-15 07:49:06',NULL,0,NULL),(0x019E2AC26759756BA87E790E7D2EB1C7,0x0196D4D7100070008000000000000012,'desobox138','desobox138@acanok.com',NULL,'$2a$10$ggbSAxEQZGqJpJE3LSm1AetknQlbN/GhDNZanDyrXpGBXBPmVw.G2',0,NULL,NULL,1,0,NULL,'2026-05-15 08:30:44',NULL,'2026-05-15 08:30:44',NULL,0,NULL),(0x019E2B00DADB70F39A41D405BEF6DCD2,0x0196D4D7100070008000000000000012,'violentsmelt','violent.smelt.qlxg@hidingmail.net',NULL,'$2a$10$DzJy0CANdGZzDJw5EreVlOkdN.BPJAgfc4tEYlgQjkncaIyFj24fy',0,NULL,NULL,1,0,NULL,'2026-05-15 09:38:57',NULL,'2026-05-15 09:38:57',NULL,0,NULL),(0x019E301A0E887A6AA1FB389F03B64D5D,0x0196D4D7100070008000000000000012,'goyalex502','goyalex502@getasail.com',NULL,'$2a$10$kwQ7t7HTKjmGJnLOWw2qu..Euw9.dxLfDrVN0ak8/quzt6cZgR.8i',0,NULL,'2026-05-16 13:01:34',1,0,NULL,'2026-05-16 09:24:35',NULL,'2026-05-16 09:24:35',NULL,1,'2026-05-16 09:28:11'),(0x019E310A874B7CF0BECFB41CD7635EFB,0x0196D4D7100070008000000000000012,'dheeraj','6tzqt0h4gm@lnovic.com',NULL,'$2a$10$.woZ6NLdLdqgfbyMSDoHQOZ9RoWpXGX/RnjqQB8goOPaYLdsLRye.',0,NULL,'2026-05-16 14:03:14',1,0,NULL,'2026-05-16 13:47:14',NULL,'2026-05-16 13:47:14',NULL,1,'2026-05-16 13:57:18'),(0x019E39BB863F718DACDE8E499BF5F95D,0x0196D4D7100070008000000000000012,'sh1gb','sh1gb@wshu.net',NULL,'$2a$10$nhnHRP3xNz.hqiHlzPegduWakl34rcfu70Nuz.6BiLU.a7sB0353e',0,NULL,'2026-05-18 06:27:01',1,0,NULL,'2026-05-18 06:17:32',NULL,'2026-05-18 06:17:32',NULL,1,'2026-05-18 06:22:42'),(0x019E3A10EDA2714089D1F18826EEC8CD,0x0196D4D7100070008000000000000012,'skaynin','skaynin.domenico@dropons.com',NULL,'$2a$10$kpAVdfVvZGivjWv2qUDLGu9oxCpQ1IMxq6z.Xj4138a7zdYdZmxz6',0,NULL,NULL,1,0,NULL,'2026-05-18 07:50:49',NULL,'2026-05-18 07:50:49',NULL,0,NULL),(0x019E3A1504E278438AAC506877CA8DD4,0x0196D4D7100070008000000000000012,'evrr0y57j9','evrr0y57j9@yzcalo.com',NULL,'$2a$10$J6QM.oZRs2w3/knZfkMFb.jDJvwyXfyN7JsyHLmeXtuwaPct86.66',0,NULL,NULL,1,0,NULL,'2026-05-18 07:55:17',NULL,'2026-05-18 07:55:17',NULL,1,'2026-05-18 07:55:58'),(0x019E3A5D53887C03939E74C95827622D,0x0196D4D7100070008000000000000012,'mission','mission@yzcalo.com',NULL,'$2a$10$Vou6Mkwqmi.ee3y2qZkAluIveKpuPCkHkfRXC5RjaELe6PQHEyXo.',0,NULL,'2026-05-18 09:15:01',1,0,NULL,'2026-05-18 09:14:16',NULL,'2026-05-18 09:14:16',NULL,1,'2026-05-18 09:14:52'),(0x019E3AF933297781B6DF31455E038815,0x0196D4D7100070008000000000000012,'vishal','vishal@bwmyga.com',NULL,'$2a$10$3e6Y1y/P8bUl2er6u734pOeNiDEimmw1rtXYZa.MK3EndP3QvPsrm',0,NULL,'2026-05-18 12:05:42',1,0,NULL,'2026-05-18 12:04:31',NULL,'2026-05-18 12:04:31',NULL,1,'2026-05-18 12:05:12'),(0x019E3B79E68F7443941DD9B336E7CAE0,0x0196D4D7100070008000000000000002,'microsoft','microsoft@yzcalo.com',NULL,'$2a$10$cZay3TPDJiLs1WVvlqNyd.wz8OxdOYwa1moQxfZxfE85CjlSeBLJu',0,NULL,'2026-05-19 06:56:52',1,0,NULL,'2026-05-18 14:25:05',NULL,'2026-05-19 08:03:16',NULL,1,'2026-05-18 14:25:41');
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

-- Dump completed on 2026-05-20 17:43:31


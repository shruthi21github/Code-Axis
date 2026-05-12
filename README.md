# Notification API - Code Axis Backend

## Project
Code Axis SaaS Platform

## Module
Notification System

---

# Overview

The Notification API is responsible for managing system alerts and user notifications inside the Code Axis platform.

This module supports:
- Creating notifications
- Fetching notifications
- User-specific notifications
- Marking notifications as read

The API is designed to integrate with:
- Task Management
- Project Management
- Attendance System
- Dashboard Activities

---

# Current Implementation

This version is a backend MVP implementation.

Current features:
- In-memory notification storage
- REST APIs
- DTO-based architecture
- Layered architecture
- Lombok support

This version DOES NOT yet include:
- MySQL database
- JPA/Hibernate
- Real-time WebSocket updates
- Persistent storage

---

# Tech Stack

- Java 17
- Spring Boot
- Spring MVC
- Spring Security
- Lombok
- Maven

---

# Architecture

The module follows layered architecture:

Controller Layer
→ Handles API requests

Service Layer
→ Business logic

Repository Layer
→ Temporary in-memory storage

DTO Layer
→ Request/response transfer

Entity Layer
→ Notification model

---

# Folder Structure

src/main/java/com/codeaxis

├── controller
│   └── NotificationController.java
│
├── service
│   └── NotificationService.java
│
├── repository
│   └── NotificationRepository.java
│
├── entity
│   └── Notification.java
│
├── dto
│   ├── NotificationRequest.java
│   ├── NotificationResponse.java
│   └── ApiResponse.java

---

# Notification Entity

Fields:

| Field | Type |
|------|------|
| id | Long |
| title | String |
| message | String |
| type | String |
| isRead | boolean |
| username | String |
| createdAt | LocalDateTime |

---

# API Endpoints

---

## 1. Create Notification

### Endpoint

POST /api/notifications

### Request Body

```json
{
  "title": "Task Assigned",
  "message": "You have been assigned Dashboard UI task",
  "type": "TASK",
  "username": "employee1"
}

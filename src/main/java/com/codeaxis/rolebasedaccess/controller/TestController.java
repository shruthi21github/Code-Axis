package com.codeaxis.rolebasedaccess.controller;

import org.springframework.http.ResponseEntity;

import org.springframework.security.access.prepost.PreAuthorize;

import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/test")
public class TestController {

    // =========================================
    // PUBLIC API
    // =========================================

    @GetMapping("/public")
    public ResponseEntity<?> publicApi() {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Public API Working Successfully"
                ));
    }

    // =========================================
    // RBAC AUTH TEST
    // =========================================

    @GetMapping("/rbac")

    @PreAuthorize(
            "hasAnyRole('ADMIN', 'EMPLOYEE')")

    public ResponseEntity<?> rbacTest() {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "RBAC Authentication Working",

                        "access",
                        "ADMIN and EMPLOYEE allowed"
                ));
    }

    // =========================================
    // EMPLOYEE MODULE TEST
    // =========================================

    @GetMapping("/employee")

    @PreAuthorize(
            "hasAuthority('employees.update')")

    public ResponseEntity<?> employeeModuleTest() {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Employee Update/Delete API Access Granted"
                ));
    }

    // =========================================
    // TASK MODULE TEST
    // =========================================

    @GetMapping("/tasks")

    @PreAuthorize(
            "hasAuthority('tasks.read')")

    public ResponseEntity<?> taskModuleTest() {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Task CRUD API Access Granted"
                ));
    }

    // =========================================
    // ATTENDANCE MODULE TEST
    // =========================================

    @GetMapping("/attendance")

    @PreAuthorize(
            "hasAnyRole('ADMIN', 'EMPLOYEE')")

    public ResponseEntity<?> attendanceModuleTest() {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Attendance Checkout API Access Granted"
                ));
    }

    // =========================================
    // REPORT MODULE TEST
    // =========================================

    @GetMapping("/reports")

    @PreAuthorize(
            "hasAuthority('reports.read')")

    public ResponseEntity<?> reportModuleTest() {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Performance Report API Access Granted"
                ));
    }

    // =========================================
    // ADMIN ONLY TEST
    // =========================================

    @GetMapping("/admin")

    @PreAuthorize(
            "hasRole('ADMIN')")

    public ResponseEntity<?> adminOnlyTest() {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "ADMIN Access Granted"
                ));
    }
}
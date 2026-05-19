package com.codeaxis.rolebasedaccess.controller;

import com.codeaxis.rolebasedaccess.entity.Attendance;
import com.codeaxis.rolebasedaccess.service.AttendanceService;

import org.springframework.http.ResponseEntity;

import org.springframework.security.access.prepost.PreAuthorize;

import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/attendance")
public class AttendanceController {

    private final AttendanceService attendanceService;

    public AttendanceController(
            AttendanceService attendanceService) {

        this.attendanceService = attendanceService;
    }

    // CREATE CHECK-IN EVENT

    @PostMapping

    @PreAuthorize(
            "hasAuthority('employees.update')")

    public ResponseEntity<?> createAttendance(
            @RequestBody Attendance attendance) {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Attendance created successfully",

                        "data",
                        attendanceService.createAttendance(
                                attendance)
                ));
    }

    // GET ALL EVENTS

    @GetMapping

    @PreAuthorize(
            "hasAuthority('employees.read')")

    public ResponseEntity<?> getAllAttendance() {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Attendance fetched successfully",

                        "data",
                        attendanceService.getAllAttendance()
                ));
    }

    // GET EVENT BY ID

    @GetMapping("/{id}")

    @PreAuthorize(
            "hasAuthority('employees.read')")

    public ResponseEntity<?> getAttendanceById(
            @PathVariable UUID id) {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Attendance fetched successfully",

                        "data",
                        attendanceService.getAttendanceById(
                                id)
                ));
    }

    // CHECK-OUT / UPDATE EVENT

    @PutMapping("/{id}")

    @PreAuthorize(
            "hasAuthority('employees.update')")

    public ResponseEntity<?> updateAttendance(

            @PathVariable UUID id,

            @RequestBody Attendance attendance) {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Attendance updated successfully",

                        "data",
                        attendanceService.updateAttendance(
                                id,
                                attendance)
                ));
    }

    // DELETE EVENT

    @DeleteMapping("/{id}")

    @PreAuthorize(
            "hasAuthority('employees.delete')")

    public ResponseEntity<?> deleteAttendance(
            @PathVariable UUID id) {

        return ResponseEntity.ok(
                Map.of(

                        "message",

                        attendanceService.deleteAttendance(
                                id)
                ));
    }
}
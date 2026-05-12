package com.codeaxis.rolebasedaccess.controller;

import com.codeaxis.rolebasedaccess.service.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/attendance")
public class AttendanceController {

    @Autowired
    private AttendanceService attendanceService;

    @PostMapping("/check-in/{employeeId}")
    public ResponseEntity<?> checkIn(@PathVariable Long employeeId) {
        return attendanceService.checkIn(employeeId);
    }

    @PutMapping("/check-out/{employeeId}")
    public ResponseEntity<?> checkOut(@PathVariable Long employeeId) {
        return attendanceService.checkOut(employeeId);
    }
}
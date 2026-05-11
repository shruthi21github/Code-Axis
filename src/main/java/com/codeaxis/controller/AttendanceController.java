package com.codeaxis.controller;
import com.codeaxis.dto.ApiResponse;
import com.codeaxis.dto.AttendanceRequest;
import com.codeaxis.entity.Attendance;
import com.codeaxis.service.AttendanceService;

import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/attendance")
@RequiredArgsConstructor
public class AttendanceController {

    private final AttendanceService attendanceService;

    @PostMapping("/check-in")
    public ApiResponse<Attendance> checkIn(
            @RequestBody AttendanceRequest request
    ) {

        return attendanceService.checkIn(
                request.getStudentId()
        );
    }
}
package com.codeaxis.service;

import com.codeaxis.dto.ApiResponse;
import com.codeaxis.entity.Attendance;

public interface AttendanceService {

    ApiResponse<Attendance> checkIn(Long studentId);
}
package com.codeaxis.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Attendance {

    private Long attendanceId;

    private Long studentId;

    private String studentName;

    private LocalDate date;

    private LocalTime checkInTime;

    private AttendanceStatus status;
}
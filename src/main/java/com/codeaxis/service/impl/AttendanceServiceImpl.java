package com.codeaxis.service.impl;

import com.codeaxis.dto.ApiResponse;
import com.codeaxis.entity.Attendance;
import com.codeaxis.entity.AttendanceStatus;
import com.codeaxis.entity.Student;
import com.codeaxis.service.AttendanceService;
import com.codeaxis.service.StudentService;
import com.codeaxis.util.AttendanceFileUtil;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AttendanceServiceImpl
        implements AttendanceService {

    private final StudentService studentService;

    private static final LocalTime OFFICE_START_TIME =
            LocalTime.of(9, 0);

    private static final LocalTime ABSENT_TIME =
            LocalTime.of(13, 0);

    @Override
    public ApiResponse<Attendance> checkIn(Long studentId) {

        Student student =
                studentService.getStudentById(studentId);

        if (student == null) {

            return new ApiResponse<>(
                    false,
                    "Student not found",
                    null
            );
        }

        List<Attendance> attendanceList =
                AttendanceFileUtil.readAttendance();

        LocalDate today = LocalDate.now();

        boolean alreadyCheckedIn =
                attendanceList.stream()
                        .anyMatch(attendance ->
                                attendance.getStudentId()
                                        .equals(studentId)
                                        &&
                                        attendance.getDate()
                                                .equals(today)
                        );

        if (alreadyCheckedIn) {

            return new ApiResponse<>(
                    false,
                    "Student already checked in today",
                    null
            );
        }

        LocalTime currentTime = LocalTime.now();

        AttendanceStatus status =
                determineStatus(currentTime);

        Long attendanceId =
                (long) (attendanceList.size() + 1);

        Attendance attendance = Attendance.builder()
                .attendanceId(attendanceId)
                .studentId(student.getId())
                .studentName(student.getName())
                .date(today)
                .checkInTime(currentTime)
                .status(status)
                .build();

        attendanceList.add(attendance);

        AttendanceFileUtil.writeAttendance(attendanceList);

        return new ApiResponse<>(
                true,
                "Check-in successful",
                attendance
        );
    }

    private AttendanceStatus determineStatus(
            LocalTime checkInTime
    ) {

        if (!checkInTime.isAfter(OFFICE_START_TIME)) {
            return AttendanceStatus.PRESENT;
        }

        if (checkInTime.isAfter(ABSENT_TIME)) {
            return AttendanceStatus.ABSENT;
        }

        return AttendanceStatus.LATE;
    }
}
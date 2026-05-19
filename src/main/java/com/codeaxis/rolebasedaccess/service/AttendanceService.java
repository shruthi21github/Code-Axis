package com.codeaxis.rolebasedaccess.service;

import com.codeaxis.rolebasedaccess.entity.Attendance;
import com.codeaxis.rolebasedaccess.exception.ResourceNotFoundException;
import com.codeaxis.rolebasedaccess.repository.AttendanceRepository;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class AttendanceService {

    private final AttendanceRepository attendanceRepository;

    public AttendanceService(
            AttendanceRepository attendanceRepository) {

        this.attendanceRepository = attendanceRepository;
    }

    // CREATE ATTENDANCE

    public Attendance createAttendance(
            Attendance attendance) {

        return attendanceRepository.save(attendance);
    }

    // GET ALL ATTENDANCE

    public List<Attendance> getAllAttendance() {

        return attendanceRepository.findAll();
    }

    // GET ATTENDANCE BY ID

    public Attendance getAttendanceById(UUID id) {

        return attendanceRepository.findById(id)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Attendance event not found"));
    }

    // UPDATE ATTENDANCE

    public Attendance updateAttendance(
            UUID id,
            Attendance attendanceDetails) {

        Attendance attendance =
                attendanceRepository.findById(id)
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Attendance event not found"));

        if (attendanceDetails.getUserId() != null) {
            attendance.setUserId(
                    attendanceDetails.getUserId());
        }

        if (attendanceDetails.getAttendanceEventTypeId() != null) {
            attendance.setAttendanceEventTypeId(
                    attendanceDetails.getAttendanceEventTypeId());
        }

        if (attendanceDetails.getEventAt() != null) {
            attendance.setEventAt(
                    attendanceDetails.getEventAt());
        }

        if (attendanceDetails.getNotes() != null) {
            attendance.setNotes(
                    attendanceDetails.getNotes());
        }

        return attendanceRepository.save(attendance);
    }

    // DELETE ATTENDANCE

    public String deleteAttendance(UUID id) {

        Attendance attendance =
                attendanceRepository.findById(id)
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Attendance event not found"));

        attendanceRepository.delete(attendance);

        return "Attendance event deleted successfully";
    }
}
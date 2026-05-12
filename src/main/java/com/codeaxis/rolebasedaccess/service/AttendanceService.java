package com.codeaxis.rolebasedaccess.service;

import com.codeaxis.rolebasedaccess.entity.Attendance;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class AttendanceService {

    private final String FILE_PATH = "attendance.json";
    private final ObjectMapper objectMapper = new ObjectMapper();

    // Helper: Reads the JSON file
    private List<Attendance> readFromFile() {
        try {
            File file = new File(FILE_PATH);
            if (!file.exists()) return new ArrayList<>();
            return objectMapper.readValue(file, new TypeReference<List<Attendance>>() {});
        } catch (IOException e) {
            return new ArrayList<>();
        }
    }

    // Helper: Saves data back to JSON file
    private void writeToFile(List<Attendance> list) {
        try {
            objectMapper.writeValue(new File(FILE_PATH), list);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Task B-10: Check-in
    public ResponseEntity<?> checkIn(Long employeeId) {
        List<Attendance> list = readFromFile();
        long newId = list.size() + 1;
        
        Attendance attendance = new Attendance(newId, employeeId, LocalDateTime.now().toString(), null, "Present");
        list.add(attendance);
        
        writeToFile(list);
        return ResponseEntity.ok(formatResponse(true, "Checked in successfully", null));
    }

    // Task B-11: Check-out (Your task for today)
    public ResponseEntity<?> checkOut(Long employeeId) {
        List<Attendance> list = readFromFile();
        boolean updated = false;

        for (Attendance attendance : list) {
            // Find record for this employee where checkOutTime is still null
            if (attendance.getEmployeeId().equals(employeeId) && attendance.getCheckOutTime() == null) {
                attendance.setCheckOutTime(LocalDateTime.now().toString());
                updated = true;
                break;
            }
        }

        if (updated) {
            writeToFile(list);
            return ResponseEntity.ok(formatResponse(true, "Checked out successfully", null));
        }

        return ResponseEntity.status(404)
                .body(formatResponse(false, "No active check-in found for this employee", null));
    }

    // Standard Response Format
    private Map<String, Object> formatResponse(boolean status, String message, Object data) {
        Map<String, Object> response = new HashMap<>();
        response.put("status", status);
        response.put("message", message);
        response.put("data", data);
        return response;
    }
}
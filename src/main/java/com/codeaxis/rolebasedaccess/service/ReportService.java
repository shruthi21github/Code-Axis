package com.codeaxis.rolebasedaccess.service;

import com.codeaxis.rolebasedaccess.entity.PerformanceReport;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import java.util.*;

@Service
public class ReportService {

    public ResponseEntity<?> getPerformanceReport(Long employeeId) {
        // Business Logic for Task B-14
        int totalTasks = 10; 
        int completedTasks = 9; 
        double percentage = ((double) completedTasks / totalTasks) * 100;

        String rating;
        if (percentage >= 90) rating = "Excellent";
        else if (percentage >= 75) rating = "Good";
        else if (percentage >= 50) rating = "Average";
        else rating = "Needs Improvement";

        PerformanceReport report = new PerformanceReport(employeeId, totalTasks, completedTasks, percentage, rating);

        return ResponseEntity.ok(formatResponse(true, "Performance report generated successfully", report));
    }

    private Map<String, Object> formatResponse(boolean status, String message, Object data) {
        Map<String, Object> response = new HashMap<>();
        response.put("status", status);
        response.put("message", message);
        response.put("data", data);
        return response;
    }
}
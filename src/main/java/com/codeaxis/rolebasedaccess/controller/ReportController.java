package com.codeaxis.rolebasedaccess.controller;

import com.codeaxis.rolebasedaccess.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/reports")
public class ReportController {

    @Autowired
    private ReportService reportService;

    @GetMapping("/performance/{employeeId}")
    public ResponseEntity<?> getPerformance(@PathVariable Long employeeId) {
        return reportService.getPerformanceReport(employeeId);
    }
}
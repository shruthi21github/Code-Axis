package com.codeaxis.rolebasedaccess.controller;

import com.codeaxis.rolebasedaccess.entity.PerformanceReport;
import com.codeaxis.rolebasedaccess.service.ReportService;

import org.springframework.http.ResponseEntity;

import org.springframework.security.access.prepost.PreAuthorize;

import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/reports")
public class ReportController {

    private final ReportService reportService;

    public ReportController(
            ReportService reportService) {

        this.reportService = reportService;
    }

    // CREATE REPORT

    @PostMapping

    @PreAuthorize(
            "hasAuthority('reports.create')")

    public ResponseEntity<?> createReport(
            @RequestBody PerformanceReport report) {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Performance report created successfully",

                        "data",
                        reportService.createReport(report)
                ));
    }

    // GET ALL REPORTS

    @GetMapping

    @PreAuthorize(
            "hasAuthority('reports.read')")

    public ResponseEntity<?> getAllReports() {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Performance reports fetched successfully",

                        "data",
                        reportService.getAllReports()
                ));
    }

    // GET REPORT BY ID

    @GetMapping("/{id}")

    @PreAuthorize(
            "hasAuthority('reports.read')")

    public ResponseEntity<?> getReportById(
            @PathVariable UUID id) {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Performance report fetched successfully",

                        "data",
                        reportService.getReportById(id)
                ));
    }

    // UPDATE REPORT

    @PutMapping("/{id}")

    @PreAuthorize(
            "hasAuthority('reports.update')")

    public ResponseEntity<?> updateReport(

            @PathVariable UUID id,

            @RequestBody PerformanceReport report) {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Performance report updated successfully",

                        "data",
                        reportService.updateReport(
                                id,
                                report)
                ));
    }

    // DELETE REPORT

    @DeleteMapping("/{id}")

    @PreAuthorize(
            "hasAuthority('reports.delete')")

    public ResponseEntity<?> deleteReport(
            @PathVariable UUID id) {

        return ResponseEntity.ok(
                Map.of(

                        "message",

                        reportService.deleteReport(id)
                ));
    }
}
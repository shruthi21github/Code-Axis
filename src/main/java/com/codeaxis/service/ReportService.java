package com.codeaxis.service;

import com.codeaxis.exception.ResourceNotFoundException;
import com.codeaxis.repository.ReportRepository;
import com.codeaxis.entity.PerformanceReport;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class ReportService {

    private final ReportRepository reportRepository;

    public ReportService(
            ReportRepository reportRepository) {

        this.reportRepository = reportRepository;
    }

    // CREATE REPORT

    public PerformanceReport createReport(
            PerformanceReport report) {

        return reportRepository.save(report);
    }

    // GET ALL REPORTS

    public List<PerformanceReport> getAllReports() {

        return reportRepository.findAll();
    }

    // GET REPORT BY ID

    public PerformanceReport getReportById(UUID id) {

        return reportRepository.findById(id)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Report not found"));
    }

    // UPDATE REPORT

    public PerformanceReport updateReport(
            UUID id,
            PerformanceReport reportDetails) {

        PerformanceReport report =
                reportRepository.findById(id)
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Report not found"));

        if (reportDetails.getUserId() != null) {
            report.setUserId(
                    reportDetails.getUserId());
        }

        if (reportDetails.getReportTypeId() != null) {
            report.setReportTypeId(
                    reportDetails.getReportTypeId());
        }

        if (reportDetails.getReportName() != null) {
            report.setReportName(
                    reportDetails.getReportName());
        }

        if (reportDetails.getFileName() != null) {
            report.setFileName(
                    reportDetails.getFileName());
        }

        if (reportDetails.getFilePath() != null) {
            report.setFilePath(
                    reportDetails.getFilePath());
        }

        if (reportDetails.getGeneratedAt() != null) {
            report.setGeneratedAt(
                    reportDetails.getGeneratedAt());
        }

        return reportRepository.save(report);
    }

    // DELETE REPORT

    public String deleteReport(UUID id) {

        PerformanceReport report =
                reportRepository.findById(id)
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Report not found"));

        reportRepository.delete(report);

        return "Report deleted successfully";
    }
}
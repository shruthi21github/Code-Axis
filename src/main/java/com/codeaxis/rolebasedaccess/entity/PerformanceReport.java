package com.codeaxis.rolebasedaccess.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "reports")

@AttributeOverride(
        name = "id",
        column = @Column(
                name = "pk_report_id",
                columnDefinition = "BINARY(16)"
        )
)
public class PerformanceReport extends BaseEntity {

    @Column(name = "fk_user_id")
    private UUID userId;

    @Column(name = "fk_report_type_id")
    private UUID reportTypeId;

    @Column(name = "report_name")
    private String reportName;

    @Column(name = "file_name")
    private String fileName;

    @Column(name = "file_path")
    private String filePath;

    @Column(name = "generated_at")
    private LocalDateTime generatedAt;

    // USER ID

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    // REPORT TYPE ID

    public UUID getReportTypeId() {
        return reportTypeId;
    }

    public void setReportTypeId(
            UUID reportTypeId) {

        this.reportTypeId = reportTypeId;
    }

    // REPORT NAME

    public String getReportName() {
        return reportName;
    }

    public void setReportName(
            String reportName) {

        this.reportName = reportName;
    }

    // FILE NAME

    public String getFileName() {
        return fileName;
    }

    public void setFileName(
            String fileName) {

        this.fileName = fileName;
    }

    // FILE PATH

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(
            String filePath) {

        this.filePath = filePath;
    }

    // GENERATED AT

    public LocalDateTime getGeneratedAt() {
        return generatedAt;
    }

    public void setGeneratedAt(
            LocalDateTime generatedAt) {

        this.generatedAt = generatedAt;
    }
}
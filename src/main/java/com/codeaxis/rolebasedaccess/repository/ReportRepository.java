package com.codeaxis.rolebasedaccess.repository;

import com.codeaxis.rolebasedaccess.entity.PerformanceReport;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ReportRepository
        extends JpaRepository<PerformanceReport, UUID> {
}
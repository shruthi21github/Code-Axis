package com.codeaxis.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.codeaxis.entity.PerformanceReport;

import java.util.UUID;

@Repository
public interface ReportRepository
        extends JpaRepository<PerformanceReport, UUID> {
}
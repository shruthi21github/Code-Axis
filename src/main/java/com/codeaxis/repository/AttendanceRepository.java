package com.codeaxis.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.codeaxis.entity.Attendance;

import java.util.UUID;

@Repository
public interface AttendanceRepository
        extends JpaRepository<Attendance, UUID> {
}
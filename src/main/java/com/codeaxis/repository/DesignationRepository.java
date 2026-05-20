package com.codeaxis.repository;

import com.codeaxis.entity.Designation;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface DesignationRepository
        extends JpaRepository<Designation, UUID> {
}
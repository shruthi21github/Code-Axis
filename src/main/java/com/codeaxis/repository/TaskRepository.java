package com.codeaxis.repository;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.codeaxis.entity.Task;

public interface TaskRepository
        extends JpaRepository<Task, UUID> {

    Optional<Task> findByPkTaskIdAndIsDeletedFalse(
            UUID pkTaskId);

    /*
     * ===========================================================================
     * DASHBOARD COUNTS
     * ===========================================================================
     */

    long countByFkTaskStatusIdStatusName(
            String statusName);

    long countByFkTaskStatusIdStatusNameIgnoreCaseAndIsDeletedFalse(
            String statusName);

    long countByIsDeletedFalse();
}

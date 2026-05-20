package com.codeaxis.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.codeaxis.entity.TaskPriority;

@Repository
public interface TaskPriorityRepository
        extends JpaRepository<TaskPriority, UUID> {

}
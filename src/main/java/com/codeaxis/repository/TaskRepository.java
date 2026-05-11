package com.codeaxis.repository;

import com.codeaxis.entity.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.time.LocalDate;

public interface TaskRepository extends JpaRepository<Task, Long> {

    //deadline find task by deadline
    List<Task> findByDeadLineBefore(LocalDate date);

    // find task by status
    List<Task> findByStatus(String status);
}

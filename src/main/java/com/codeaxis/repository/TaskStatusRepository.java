package com.codeaxis.repository; 
 
import com.codeaxis.entity.TaskStatus; 
import org.springframework.data.jpa.repository.JpaRepository; 
import java.util.Optional; 
import java.util.UUID; 
 
public interface TaskStatusRepository extends JpaRepository<TaskStatus, UUID> { 
    Optional<TaskStatus> findByStatusNameIgnoreCase(String statusName); 
} 
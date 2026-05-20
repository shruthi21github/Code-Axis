package com.codeaxis.repository; 
 
import com.codeaxis.entity.TaskStatusHistory; 
import org.springframework.data.jpa.repository.JpaRepository; 
import java.util.UUID; 
 
public interface TaskStatusHistoryRepository 
        extends JpaRepository<TaskStatusHistory, UUID> { 
} 
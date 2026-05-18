package com.codeaxis.repository; 
 
import com.codeaxis.entity.Task; 
import org.springframework.data.jpa.repository.JpaRepository; 
import java.util.Optional; 
import java.util.UUID; 
 
public interface TaskRepository extends JpaRepository<Task, UUID> { 
 
    Optional<Task> findByPkTaskIdAndIsDeletedFalse(UUID pkTaskId); 
 
    long countByFkTaskStatusStatusName(String statusName); 

    // Count tasks by status name 
long countByFkTaskStatus_StatusNameIgnoreCaseAndIsDeletedFalse( 
        String statusName); 
 
// Count all non-deleted tasks 
long countByIsDeletedFalse();

} 
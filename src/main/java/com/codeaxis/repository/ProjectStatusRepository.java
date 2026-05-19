package com.codeaxis.repository; 
 
import com.codeaxis.entity.ProjectStatus; 
import org.springframework.data.jpa.repository.JpaRepository; 
import java.util.Optional; 
import java.util.UUID; 
 
public interface ProjectStatusRepository 
        extends JpaRepository<ProjectStatus, UUID> { 
 
    Optional<ProjectStatus> findByStatusNameIgnoreCase(String statusName); 
} 
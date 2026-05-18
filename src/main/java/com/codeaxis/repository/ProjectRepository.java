package com.codeaxis.repository; 
 
import com.codeaxis.entity.Project; 
import org.springframework.data.jpa.repository.JpaRepository; 
import org.springframework.data.domain.Page; 
import org.springframework.data.domain.Pageable; 
import com.codeaxis.entity.ProjectStatus; 
import java.util.UUID; 
 
public interface ProjectRepository extends JpaRepository<Project, UUID> { 
 
    boolean existsByProjectCode(String projectCode); 
 
    // Pageable — as per document performance requirements 
    Page<Project> findAllByIsDeletedFalse(Pageable pageable); 
 
// Count projects by status object 
long countByFkProjectStatusAndIsDeletedFalse(ProjectStatus status); 
 
// Count all non-deleted projects 
long countByIsDeletedFalse(); 
} 
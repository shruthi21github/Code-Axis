package com.codeaxis.dto;


import jakarta.validation.constraints.NotBlank; 
import lombok.Data; 
import java.time.LocalDateTime; 
 
@Data 
public class ProjectRequest { 
 
    @NotBlank(message = "Project code must not be blank") 
    private String projectCode; 
 
    @NotBlank(message = "Project name must not be blank") 
    private String projectName; 
 
    private String projectDescription; 
 
    private LocalDateTime startAt; 
 
    private LocalDateTime deadlineAt; 
 
    // Must match a status_name in project_statuses table 
    // e.g. "PLANNING", "ACTIVE", "ON_HOLD", "COMPLETED" 
    private String statusName; 
} 

package com.codeaxis.dto;


import lombok.Data; 
import java.time.LocalDateTime; 
import java.util.UUID; 
 
@Data 
public class ProjectResponse { 
    private UUID projectId; 
    private String projectCode; 
    private String projectName; 
    private String projectDescription; 
    private String statusName; 
    private LocalDateTime startAt; 
    private LocalDateTime deadlineAt; 
    private LocalDateTime createdAt; 
} 

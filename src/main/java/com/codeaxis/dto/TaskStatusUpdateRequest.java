package com.codeaxis.dto;


import jakarta.validation.constraints.NotBlank; 
import lombok.Data; 
 
@Data 
public class TaskStatusUpdateRequest { 
 
    // Must match status_name in task_statuses table:

    @NotBlank(message = "Status must not be blank") 
    private String statusName; 
 
    private String remarks; // optional note for history 
} 

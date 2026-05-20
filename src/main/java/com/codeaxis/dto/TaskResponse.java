package com.codeaxis.dto;

import lombok.Data; 
import java.time.LocalDateTime; 
import java.util.UUID; 
 
@Data 
public class TaskResponse { 
    private UUID taskId; 
    private String taskTitle; 
    private String statusName; 
    private String priorityName; 
    private LocalDateTime deadlineAt; 
    private LocalDateTime completedAt; 
    private LocalDateTime updatedAt; 
}  

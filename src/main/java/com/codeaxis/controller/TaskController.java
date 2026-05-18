package com.codeaxis.controller; 
 
import com.codeaxis.dto.TaskStatusUpdateRequest; 
import com.codeaxis.dto.ApiResponse; 
import com.codeaxis.dto.TaskResponse; 
import com.codeaxis.service.TaskService; 
import jakarta.validation.Valid; 
import lombok.RequiredArgsConstructor; 
import org.springframework.http.ResponseEntity; 
import org.springframework.web.bind.annotation.*; 
import java.util.UUID; 
 
@RestController 
@RequestMapping("/api/tasks") 
@RequiredArgsConstructor 
public class TaskController { 
 
    private final TaskService taskService; 
 
    @PutMapping("/{id}/status") 
    public ResponseEntity<?> updateTaskStatus( 
            @PathVariable UUID id, 
            @Valid @RequestBody TaskStatusUpdateRequest request) { 
 
        TaskResponse response = taskService.updateTaskStatus(id, request); 
 
        return ResponseEntity.ok(ApiResponse.builder() 
                .status(true) 
                .message("Task status updated successfully") 
                .data(response) 
                .build()); 
    } 
} 
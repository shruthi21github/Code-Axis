package com.codeaxis.controller; 
 
import com.codeaxis.dto.ProjectRequest; 
import com.codeaxis.dto.ApiResponse; 
import com.codeaxis.dto.ProjectResponse; 
import com.codeaxis.service.ProjectService; 
import jakarta.validation.Valid; 
import lombok.RequiredArgsConstructor; 
import org.springframework.http.HttpStatus; 
import org.springframework.http.ResponseEntity; 
import org.springframework.web.bind.annotation.*; 
 
@RestController 
@RequestMapping("/api/projects") 
@RequiredArgsConstructor 
public class ProjectController { 
 
    private final ProjectService projectService; 
 
    @PostMapping 
    public ResponseEntity<?> createProject( 
            @Valid @RequestBody ProjectRequest request) { 
 
        ProjectResponse response = projectService.createProject(request); 
 
        return ResponseEntity.status(HttpStatus.CREATED) 
                .body(ApiResponse.builder() 
                        .status(true) 
                        .message("Project created successfully") 
                        .data(response) 
                        .build()); 
    } 
} 
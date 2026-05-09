package com.codeaxis.controller;

import com.codeaxis.dto.ApiResponse;
import com.codeaxis.dto.AssignStudentsRequest;
import com.codeaxis.entity.Project;
import com.codeaxis.service.ProjectService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/projects")
@RequiredArgsConstructor
public class ProjectController {

    private final ProjectService projectService;

    @PostMapping
    public ResponseEntity<ApiResponse<Project>>
    createProject(
            @RequestBody Project project) {

        Project createdProject =
                projectService.createProject(project);

        return ResponseEntity.ok(
                new ApiResponse<>(
                        true,
                        "Project created successfully",
                        createdProject
                )
        );
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<Project>>>
    getProjects() {

        List<Project> projects =
                projectService.getAllProjects();

        return ResponseEntity.ok(
                new ApiResponse<>(
                        true,
                        "Projects fetched successfully",
                        projects
                )
        );
    }

    @PostMapping("/assign-students")
    public ResponseEntity<ApiResponse<Project>>
    assignStudents(
            @Valid @RequestBody
            AssignStudentsRequest request) {

        Project updatedProject =
                projectService
                        .assignStudentsToProject(request);

        return ResponseEntity.ok(
                new ApiResponse<>(
                        true,
                        "Students assigned successfully",
                        updatedProject
                )
        );
    }
}
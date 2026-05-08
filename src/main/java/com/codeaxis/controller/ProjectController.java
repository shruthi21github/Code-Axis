package com.codeaxis.controller;

import com.codeaxis.dto.*;
import com.codeaxis.service.ProjectService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/projects")
@RequiredArgsConstructor
public class ProjectController {

    private final ProjectService projectService;

    @PostMapping
    public ResponseEntity<ProjectResponse> create(
        @Valid @RequestBody ProjectRequest request) {
        return ResponseEntity.ok(
            projectService.create(request));
    }

    @GetMapping
    public ResponseEntity<ProjectResponse> getAll() {
        return ResponseEntity.ok(
            projectService.getAll());
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProjectResponse> update(
        @PathVariable Long id,
        @Valid @RequestBody ProjectRequest request) {
        return ResponseEntity.ok(
            projectService.update(id, request));
    }
}
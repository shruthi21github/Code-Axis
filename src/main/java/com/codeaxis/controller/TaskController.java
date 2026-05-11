package com.codeaxis.controller;

import com.codeaxis.dto.*;
import com.codeaxis.service.TaskService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/tasks")
@RequiredArgsConstructor
public class TaskController {

    private final TaskService taskService;

    // POST /api/tasks
    @PostMapping
    public ResponseEntity<TaskResponse> create(
        @Valid @RequestBody TaskRequest request) {
        return ResponseEntity.ok(
            taskService.create(request));
    }

    // GET /api/tasks
    @GetMapping
    public ResponseEntity<TaskResponse> getAll() {
        return ResponseEntity.ok(
            taskService.getAll());
    }

    // PUT /api/tasks/{id} — status update + deadline
    @PutMapping("/{id}")
    public ResponseEntity<TaskResponse> updateStatus(
        @PathVariable Long id,
        @RequestBody TaskRequest request) {
        return ResponseEntity.ok(
            taskService.updateStatus(id, request));
    }
}
package com.codeaxis.controller;

import com.codeaxis.dto.ApiResponse;
import com.codeaxis.dto.TaskCreateDTO;
import com.codeaxis.dto.TaskResponse;
import com.codeaxis.dto.TaskStatusUpdateRequest;

import com.codeaxis.entity.Role;
import com.codeaxis.entity.Task;
import com.codeaxis.entity.User;

import com.codeaxis.exception.ApiException;

import com.codeaxis.service.TaskService;

import jakarta.validation.Valid;

import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/tasks")
@RequiredArgsConstructor
public class TaskController {

    /*
     * ===============================================================
     * SERVICES
     * ===============================================================
     */

    private final TaskService taskService;

    /*
     * ===============================================================
     * CREATE TASK
     * ===============================================================
     */

    @PostMapping

    @PreAuthorize("hasAuthority('tasks.create')")

    public ResponseEntity<?> createTask(
            @RequestBody TaskCreateDTO dto) {

        return ResponseEntity.ok(

                Map.of(
                        "message",
                        "Task created successfully",

                        "data",
                        taskService.createTask(dto)));
    }

    /*
     * ===============================================================
     * GET ALL TASKS
     * ===============================================================
     */

    @GetMapping

    @PreAuthorize("hasAuthority('tasks.read')")

    public ResponseEntity<?> getAllTasks() {

        return ResponseEntity.ok(

                Map.of(
                        "message",
                        "Tasks fetched successfully",

                        "data",
                        taskService.getAllTasks()));
    }

    /*
     * ===============================================================
     * GET TASK BY ID
     * ===============================================================
     */

    @GetMapping("/{id}")

    @PreAuthorize("hasAuthority('tasks.read')")

    public ResponseEntity<?> getTaskById(
            @PathVariable UUID id) {

        return ResponseEntity.ok(

                Map.of(
                        "message",
                        "Task fetched successfully",

                        "data",
                        taskService.getTaskById(id)));
    }

    /*
     * ===============================================================
     * UPDATE TASK
     * ===============================================================
     */

    @PutMapping("/{id}")

    @PreAuthorize("hasAuthority('tasks.update')")

    public ResponseEntity<?> updateTask(

            @PathVariable UUID id,

            @RequestBody Task taskDetails) {

        return ResponseEntity.ok(

                Map.of(
                        "message",
                        "Task updated successfully",

                        "data",
                        taskService.updateTask(
                                id,
                                taskDetails)));
    }

    /*
     * ===============================================================
     * DELETE TASK
     * ===============================================================
     */

    @DeleteMapping("/{id}")

    @PreAuthorize("hasAuthority('tasks.delete')")

    public ResponseEntity<?> deleteTask(
            @PathVariable UUID id) {

        return ResponseEntity.ok(

                Map.of(
                        "message",
                        taskService.deleteTask(id)));
    }

    /*
     * ===============================================================
     * UPDATE TASK STATUS
     * ===============================================================
     */

    @PutMapping("/{id}/status")

    public ResponseEntity<?> updateTaskStatus(

            @PathVariable UUID id,

            @Valid
            @RequestBody TaskStatusUpdateRequest request) {

        /*
         * ===========================================================
         * GET AUTHENTICATED USER
         * ===========================================================
         */

        Authentication authentication =
                SecurityContextHolder
                        .getContext()
                        .getAuthentication();

        User user =
                (User) authentication.getPrincipal();

        /*
         * ===========================================================
         * ROLE CHECK
         * ===========================================================
         */

        Role role = user.getFkRoleId();

        if (!role.getRoleName().equals("ADMIN")) {

            throw new ApiException(
                    HttpStatus.FORBIDDEN,
                    "Access denied");
        }

        /*
         * ===========================================================
         * UPDATE TASK STATUS
         * ===========================================================
         */

        TaskResponse response =
                taskService.updateTaskStatus(
                        id,
                        request);

        return ResponseEntity.ok(

                ApiResponse.builder()
                        .status(true)
                        .message(
                                "Task status updated successfully")
                        .data(response)
                        .build());
    }
}
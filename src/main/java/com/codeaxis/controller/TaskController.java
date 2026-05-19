package com.codeaxis.controller;

import com.codeaxis.dto.ApiResponse;
import com.codeaxis.dto.TaskResponse;
import com.codeaxis.dto.TaskStatusUpdateRequest;

import com.codeaxis.entity.Role;
import com.codeaxis.entity.User;

import com.codeaxis.exception.ApiException;

import com.codeaxis.service.TaskService;

import jakarta.validation.Valid;

import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

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

                /*
                 * ===============================================================
                 * GET AUTHENTICATED USER
                 * ===============================================================
                 */

                Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

                User user = (User) authentication.getPrincipal();

                // UUID userId = user.getPkUserId();

                /*
                 * ===============================================================
                 * ROLE CHECK
                 * ===============================================================
                 */

                Role role = user.getFkRoleId();

                if (!role.getRoleName().equals("ADMIN")) {

                        throw new ApiException(
                                        HttpStatus.FORBIDDEN,
                                        "Access denied");
                }

                /*
                 * ===============================================================
                 * UPDATE TASK
                 * ===============================================================
                 */

                TaskResponse response = taskService.updateTaskStatus(id, request);

                return ResponseEntity.ok(
                                ApiResponse.builder()
                                                .status(true)
                                                .message("Task status updated successfully")
                                                .data(response)
                                                .build());
        }
}
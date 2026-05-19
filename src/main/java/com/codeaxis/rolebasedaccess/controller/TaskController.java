package com.codeaxis.rolebasedaccess.controller;

import com.codeaxis.rolebasedaccess.entity.Task;
import com.codeaxis.rolebasedaccess.service.TaskService;

import org.springframework.http.ResponseEntity;

import org.springframework.security.access.prepost.PreAuthorize;

import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/tasks")
public class TaskController {

    private final TaskService taskService;

    public TaskController(
            TaskService taskService) {

        this.taskService = taskService;
    }

    // CREATE TASK

    @PostMapping

    @PreAuthorize(
            "hasAuthority('tasks.create')")

    public ResponseEntity<?> createTask(
            @RequestBody Task task) {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Task created successfully",

                        "data",
                        taskService.createTask(task)
                ));
    }

    // GET ALL TASKS

    @GetMapping

    @PreAuthorize(
            "hasAuthority('tasks.read')")

    public ResponseEntity<?> getAllTasks() {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Tasks fetched successfully",

                        "data",
                        taskService.getAllTasks()
                ));
    }

    // GET TASK BY ID

    @GetMapping("/{id}")

    @PreAuthorize(
            "hasAuthority('tasks.read')")

    public ResponseEntity<?> getTaskById(
            @PathVariable UUID id) {

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Task fetched successfully",

                        "data",
                        taskService.getTaskById(id)
                ));
    }

    // UPDATE TASK

    @PutMapping("/{id}")

    @PreAuthorize(
            "hasAuthority('tasks.update')")

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
                                taskDetails)
                ));
    }

    // DELETE TASK

    @DeleteMapping("/{id}")

    @PreAuthorize(
            "hasAuthority('tasks.delete')")

    public ResponseEntity<?> deleteTask(
            @PathVariable UUID id) {

        return ResponseEntity.ok(
                Map.of(

                        "message",

                        taskService.deleteTask(id)
                ));
    }
}
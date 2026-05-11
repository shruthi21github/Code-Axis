package com.codeaxis.rolebasedaccess.service;

import com.codeaxis.rolebasedaccess.entity.Task;
import com.codeaxis.rolebasedaccess.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.Map;

@Service
public class TaskService {

    @Autowired
    private TaskRepository taskRepository;

    public ResponseEntity<?> createTask(Task task) {
        taskRepository.save(task);
        return ResponseEntity.ok(formatResponse(true, "Task created successfully", null));
    }

    public ResponseEntity<?> getAllTasks() {
        return ResponseEntity.ok(formatResponse(true, "Tasks fetched successfully", taskRepository.findAll()));
    }

    public ResponseEntity<?> updateTask(Long id, Task taskDetails) {
        return taskRepository.findById(id).map(task -> {
            task.setTitle(taskDetails.getTitle());
            task.setDescription(taskDetails.getDescription());
            task.setStatus(taskDetails.getStatus());
            task.setPriority(taskDetails.getPriority());
            taskRepository.save(task);
            return ResponseEntity.ok(formatResponse(true, "Task updated successfully", null));
        }).orElse(ResponseEntity.status(404).body(formatResponse(false, "Task not found", null)));
    }

    public ResponseEntity<?> deleteTask(Long id) {
        if (taskRepository.existsById(id)) {
            taskRepository.deleteById(id);
            return ResponseEntity.ok(formatResponse(true, "Task deleted successfully", null));
        }
        return ResponseEntity.status(404).body(formatResponse(false, "Task not found", null));
    }

    private Map<String, Object> formatResponse(boolean status, String message, Object data) {
        Map<String, Object> response = new HashMap<>();
        response.put("status", status);
        response.put("message", message);
        response.put("data", data);
        return response;
    }
}
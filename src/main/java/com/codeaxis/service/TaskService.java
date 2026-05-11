package com.codeaxis.service;

import com.codeaxis.dto.TaskRequest;
import com.codeaxis.dto.TaskResponse;
import com.codeaxis.entity.Task;
import com.codeaxis.repository.TaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TaskService {

    private final TaskRepository taskRepo;

    // CREATE — POST /api/tasks
    public TaskResponse create(TaskRequest req) {
        Task task = new Task();
        task.setTitle(req.getTitle());
        task.setDescription(req.getDescription());
        task.setStatus(req.getStatus());
        task.setDeadline(LocalDate.parse(req.getDeadline()));
        task.setProjectId(req.getProjectId());
        taskRepo.save(task);
        return new TaskResponse(true, "Task created", task);
    }

    // GET ALL — GET /api/tasks
    public TaskResponse getAll() {
        List<Task> tasks = taskRepo.findAll();
        return new TaskResponse(true, "Success", tasks);
    }

    // UPDATE STATUS — PUT /api/tasks/{id}
    public TaskResponse updateStatus(Long id, TaskRequest req) {
        Task task = taskRepo.findById(id)
            .orElseThrow(() ->
                new RuntimeException("Task not found"));

        // status update
        if (req.getStatus() != null) {
            task.setStatus(req.getStatus());
        }

        // deadline tracking update
        if (req.getDeadline() != null) {
            task.setDeadline(LocalDate.parse(req.getDeadline()));
        }

        // update other fields if provided
        if (req.getTitle() != null) {
            task.setTitle(req.getTitle());
        }
        if (req.getDescription() != null) {
            task.setDescription(req.getDescription());
        }

        taskRepo.save(task);
        return new TaskResponse(true, "Task updated", task);
    }
}
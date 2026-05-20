package com.codeaxis.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.codeaxis.dto.TaskCreateDTO;
import com.codeaxis.dto.TaskResponse;
import com.codeaxis.dto.TaskStatusUpdateRequest;

import com.codeaxis.entity.Project;
import com.codeaxis.entity.Task;
import com.codeaxis.entity.TaskPriority;
import com.codeaxis.entity.TaskStatus;
import com.codeaxis.entity.TaskStatusHistory;
import com.codeaxis.entity.User;

import com.codeaxis.exception.ApiException;
import com.codeaxis.exception.ResourceNotFoundException;

import com.codeaxis.repository.ProjectRepository;
import com.codeaxis.repository.TaskPriorityRepository;
import com.codeaxis.repository.TaskRepository;
import com.codeaxis.repository.TaskStatusHistoryRepository;
import com.codeaxis.repository.TaskStatusRepository;
import com.codeaxis.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TaskService {

    /*
     * ===============================================================
     * REPOSITORIES
     * ===============================================================
     */

    private final TaskRepository taskRepository;

    private final TaskStatusRepository taskStatusRepository;

    private final TaskStatusHistoryRepository
            taskStatusHistoryRepository;

    private final ProjectRepository projectRepository;

    private final UserRepository userRepository;

    private final TaskPriorityRepository
            taskPriorityRepository;

    /*
     * ===============================================================
     * CREATE TASK
     * ===============================================================
     */

    public Task createTask(TaskCreateDTO dto) {

        Project project = projectRepository
                .findById(dto.getProjectId())
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Project not found"));

        User user = userRepository
                .findById(dto.getUserId())
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "User not found"));

        TaskStatus status = taskStatusRepository
                .findById(dto.getTaskStatusId())
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Task status not found"));

        TaskPriority priority = taskPriorityRepository
                .findById(dto.getTaskPriorityId())
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Task priority not found"));

        Task task = new Task();

        task.setPkTaskId(UUID.randomUUID());

        task.setFkProjectId(project);

        task.setFkUserId(user);

        task.setFkTaskStatusId(status);

        task.setFkTaskPriorityId(priority);

        task.setTaskTitle(dto.getTaskTitle());

        task.setTaskDescription(dto.getTaskDescription());

        task.setEstimatedHours(dto.getEstimatedHours());

        task.setActualHours(dto.getActualHours());

        task.setIsActive(dto.getIsActive());

        task.setIsDeleted(dto.getIsDeleted());

        task.setCreatedAt(LocalDateTime.now());

        task.setUpdatedAt(LocalDateTime.now());

        return taskRepository.save(task);
    }

    /*
     * ===============================================================
     * GET ALL TASKS
     * ===============================================================
     */

    public List<Task> getAllTasks() {

        return taskRepository.findAll();
    }

    /*
     * ===============================================================
     * GET TASK BY ID
     * ===============================================================
     */

    public Task getTaskById(UUID id) {

        return taskRepository.findById(id)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Task not found"));
    }

    /*
     * ===============================================================
     * UPDATE TASK
     * ===============================================================
     */

    public Task updateTask(
            UUID id,
            Task taskDetails) {

        Task task = taskRepository.findById(id)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Task not found"));

        task.setTaskTitle(taskDetails.getTaskTitle());

        task.setTaskDescription(
                taskDetails.getTaskDescription());

        task.setEstimatedHours(
                taskDetails.getEstimatedHours());

        task.setActualHours(
                taskDetails.getActualHours());

        task.setUpdatedAt(LocalDateTime.now());

        return taskRepository.save(task);
    }

    /*
     * ===============================================================
     * DELETE TASK
     * ===============================================================
     */

    public String deleteTask(UUID id) {

        Task task = taskRepository.findById(id)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Task not found"));

        task.setIsDeleted(true);

        taskRepository.save(task);

        return "Task deleted successfully";
    }

    /*
     * ===============================================================
     * UPDATE TASK STATUS
     * ===============================================================
     */

    @Transactional
    public TaskResponse updateTaskStatus(
            UUID taskId,
            TaskStatusUpdateRequest request) {

        Task task = taskRepository
                .findByPkTaskIdAndIsDeletedFalse(taskId)
                .orElseThrow(() ->
                        new ApiException(
                                HttpStatus.NOT_FOUND,
                                "Task not found"));

        TaskStatus newStatus =
                taskStatusRepository
                        .findByStatusNameIgnoreCase(
                                request.getStatusName())
                        .orElseThrow(() ->
                                new ApiException(
                                        HttpStatus.NOT_FOUND,
                                        "Task status not found"));

        task.setFkTaskStatusId(newStatus);

        if ("DONE".equalsIgnoreCase(
                request.getStatusName())) {

            task.setCompletedAt(
                    LocalDateTime.now());

        } else {

            task.setCompletedAt(null);
        }

        Task updatedTask =
                taskRepository.save(task);

        TaskStatusHistory history =
                new TaskStatusHistory();

        history.setFkTask(updatedTask);

        history.setFkTaskStatus(newStatus);

        history.setChangedAt(
                LocalDateTime.now());

        history.setRemarks(
                request.getRemarks());

        taskStatusHistoryRepository.save(history);

        return mapToResponse(updatedTask);
    }

    /*
     * ===============================================================
     * MAP RESPONSE
     * ===============================================================
     */

    private TaskResponse mapToResponse(
            Task task) {

        TaskResponse response =
                new TaskResponse();

        response.setTaskId(
                task.getPkTaskId());

        response.setTaskTitle(
                task.getTaskTitle());

        response.setStatusName(
                task.getFkTaskStatusId()
                        .getStatusName());

        response.setPriorityName(
                task.getFkTaskPriorityId()
                        .getPriorityName());

        response.setDeadlineAt(
                task.getDeadlineAt());

        response.setCompletedAt(
                task.getCompletedAt());

        response.setUpdatedAt(
                task.getUpdatedAt());

        return response;
    }
}
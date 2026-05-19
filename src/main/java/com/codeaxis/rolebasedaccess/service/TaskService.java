package com.codeaxis.rolebasedaccess.service;

import com.codeaxis.rolebasedaccess.entity.Task;
import com.codeaxis.rolebasedaccess.exception.ResourceNotFoundException;
import com.codeaxis.rolebasedaccess.repository.TaskRepository;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class TaskService {

    private final TaskRepository taskRepository;

    public TaskService(TaskRepository taskRepository) {
        this.taskRepository = taskRepository;
    }

    // CREATE TASK

    public Task createTask(Task task) {

        return taskRepository.save(task);
    }

    // GET ALL TASKS

    public List<Task> getAllTasks() {

        return taskRepository.findAll();
    }

    // GET TASK BY ID

    public Task getTaskById(UUID id) {

        return taskRepository.findById(id)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Task not found"));
    }

    // UPDATE TASK

    public Task updateTask(
            UUID id,
            Task taskDetails) {

        Task task =
                taskRepository.findById(id)
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Task not found"));

        if (taskDetails.getProjectId() != null) {
            task.setProjectId(
                    taskDetails.getProjectId());
        }

        if (taskDetails.getUserId() != null) {
            task.setUserId(
                    taskDetails.getUserId());
        }

        if (taskDetails.getTaskStatusId() != null) {
            task.setTaskStatusId(
                    taskDetails.getTaskStatusId());
        }

        if (taskDetails.getTaskPriorityId() != null) {
            task.setTaskPriorityId(
                    taskDetails.getTaskPriorityId());
        }

        if (taskDetails.getTaskTitle() != null) {
            task.setTaskTitle(
                    taskDetails.getTaskTitle());
        }

        if (taskDetails.getTaskDescription() != null) {
            task.setTaskDescription(
                    taskDetails.getTaskDescription());
        }

        if (taskDetails.getEstimatedHours() != null) {
            task.setEstimatedHours(
                    taskDetails.getEstimatedHours());
        }

        if (taskDetails.getActualHours() != null) {
            task.setActualHours(
                    taskDetails.getActualHours());
        }

        if (taskDetails.getStartAt() != null) {
            task.setStartAt(
                    taskDetails.getStartAt());
        }

        if (taskDetails.getDeadlineAt() != null) {
            task.setDeadlineAt(
                    taskDetails.getDeadlineAt());
        }

        if (taskDetails.getCompletedAt() != null) {
            task.setCompletedAt(
                    taskDetails.getCompletedAt());
        }

        if (taskDetails.getIsActive() != null) {
            task.setIsActive(
                    taskDetails.getIsActive());
        }

        return taskRepository.save(task);
    }

    // DELETE TASK

    public String deleteTask(UUID id) {

        Task task =
                taskRepository.findById(id)
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Task not found"));

        task.setIsDeleted(true);

        taskRepository.save(task);

        return "Task deleted successfully";
    }
}
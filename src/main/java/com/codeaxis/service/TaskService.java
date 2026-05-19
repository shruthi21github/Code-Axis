package com.codeaxis.service;

import java.time.LocalDateTime;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.codeaxis.dto.TaskResponse;
import com.codeaxis.dto.TaskStatusUpdateRequest;
import com.codeaxis.entity.Task;
import com.codeaxis.entity.TaskStatus;
import com.codeaxis.entity.TaskStatusHistory;
import com.codeaxis.exception.ApiException;
import com.codeaxis.repository.TaskRepository;
import com.codeaxis.repository.TaskStatusHistoryRepository;
import com.codeaxis.repository.TaskStatusRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TaskService {

    private final TaskRepository taskRepository;

    private final TaskStatusRepository taskStatusRepository;

    private final TaskStatusHistoryRepository taskStatusHistoryRepository;

    /*
     * ===========================================================================
     * UPDATE TASK STATUS
     * ===========================================================================
     */

    @Transactional
    public TaskResponse updateTaskStatus(
            UUID taskId,
            TaskStatusUpdateRequest request) {

        /*
         * ===============================================================
         * FIND TASK
         * ===============================================================
         */

        Task task = taskRepository
                .findByPkTaskIdAndIsDeletedFalse(
                        taskId)
                .orElseThrow(
                        () -> new ApiException(
                                HttpStatus.NOT_FOUND,
                                "Task not found"));

        /*
         * ===============================================================
         * FIND TASK STATUS
         * ===============================================================
         */

        TaskStatus newStatus = taskStatusRepository
                .findByStatusNameIgnoreCase(
                        request.getStatusName())
                .orElseThrow(
                        () -> new ApiException(
                                HttpStatus.NOT_FOUND,
                                "Task status not found"));

        /*
         * ===============================================================
         * UPDATE TASK STATUS
         * ===============================================================
         */

        task.setFkTaskStatusId(
                newStatus);

        /*
         * ===============================================================
         * HANDLE COMPLETED STATUS
         * ===============================================================
         */

        if ("DONE".equalsIgnoreCase(
                request.getStatusName())) {

            task.setCompletedAt(
                    LocalDateTime.now());

        } else {

            task.setCompletedAt(
                    null);
        }

        Task updatedTask = taskRepository.save(
                task);

        /*
         * ===============================================================
         * CREATE TASK STATUS HISTORY
         * ===============================================================
         */

        TaskStatusHistory history = new TaskStatusHistory();

        history.setFkTask(
                updatedTask);

        history.setFkTaskStatus(
                newStatus);

        history.setChangedAt(
                LocalDateTime.now());

        history.setRemarks(
                request.getRemarks());

        taskStatusHistoryRepository.save(
                history);

        /*
         * ===============================================================
         * RETURN RESPONSE
         * ===============================================================
         */

        return mapToResponse(
                updatedTask);
    }

    /*
     * ===========================================================================
     * MAP TASK RESPONSE
     * ===========================================================================
     */

    private TaskResponse mapToResponse(
            Task task) {

        TaskResponse response = new TaskResponse();

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

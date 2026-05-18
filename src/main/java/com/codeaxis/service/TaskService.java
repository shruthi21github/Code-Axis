package com.codeaxis.service; 
 
import com.codeaxis.dto.TaskStatusUpdateRequest; 
import com.codeaxis.dto.TaskResponse; 
import com.codeaxis.entity.Task; 
import com.codeaxis.entity.TaskStatus; 
import com.codeaxis.entity.TaskStatusHistory; 
import com.codeaxis.repository.TaskRepository; 
import com.codeaxis.repository.TaskStatusHistoryRepository; 
import com.codeaxis.repository.TaskStatusRepository; 
import lombok.RequiredArgsConstructor; 
import org.springframework.stereotype.Service; 
import org.springframework.transaction.annotation.Transactional; 
import java.time.LocalDateTime; 
import java.util.UUID; 
 
@Service 
@RequiredArgsConstructor 
public class TaskService { 
 
    private final TaskRepository taskRepository; 
    private final TaskStatusRepository taskStatusRepository; 
    private final TaskStatusHistoryRepository taskStatusHistoryRepository; 
 
    @Transactional 
    public TaskResponse updateTaskStatus( 
            UUID taskId, TaskStatusUpdateRequest request) { 
 
        // 1. Find task 
        Task task = taskRepository 
                .findByPkTaskIdAndIsDeletedFalse(taskId) 
                .orElseThrow(() -> new RuntimeException( 
                        "Task not found with id: " + taskId)); 
 
        // 2. Find new status from task_statuses table 
        TaskStatus newStatus = taskStatusRepository 
                .findByStatusNameIgnoreCase(request.getStatusName()) 
                .orElseThrow(() -> new RuntimeException( 
                        "Task status not found: " + request.getStatusName())); 
 
        // 3. Update task status 
        task.setFkTaskStatus(newStatus); 
 
        // 4. If status is DONE — set completedAt 
        if ("DONE".equalsIgnoreCase(request.getStatusName())) { 
            task.setCompletedAt(LocalDateTime.now()); 
        } else { 
            task.setCompletedAt(null); 
        } 
 
        Task updated = taskRepository.save(task); 
 
        // 5. Insert into task_status_history 
        TaskStatusHistory history = new TaskStatusHistory(); 
        history.setFkTask(updated); 
        history.setFkTaskStatus(newStatus); 
        history.setChangedAt(LocalDateTime.now()); 
        history.setRemarks(request.getRemarks()); 
        taskStatusHistoryRepository.save(history); 
 
        return mapToResponse(updated); 
    } 
 
    private TaskResponse mapToResponse(Task task) { 
        TaskResponse res = new TaskResponse(); 
        res.setTaskId(task.getPkTaskId()); 
        res.setTaskTitle(task.getTaskTitle()); 
        res.setStatusName(task.getFkTaskStatus().getStatusName()); 
        res.setPriorityName(task.getFkTaskPriority().getPriorityName()); 
        res.setDeadlineAt(task.getDeadlineAt()); 
        res.setCompletedAt(task.getCompletedAt()); 
        res.setUpdatedAt(task.getUpdatedAt()); 
        return res; 
    } 
} 
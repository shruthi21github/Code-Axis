package com.codeaxis.service; 

import com.codeaxis.dto.DashboardStatsResponse; 
import com.codeaxis.entity.ProjectStatus; 
import com.codeaxis.repository.*; 
import lombok.RequiredArgsConstructor; 
import org.springframework.stereotype.Service; 
import org.springframework.transaction.annotation.Transactional; 
 
@Service 
@RequiredArgsConstructor
public class DashboardService { 
 
    private final UserRepository        userRepository; 
    private final EmployeeRepository    employeeRepository; 
    private final ProjectRepository     projectRepository; 
    private final ProjectStatusRepository projectStatusRepository; 
    private final TaskRepository        taskRepository; 
 
    @Transactional(readOnly = true) 
    public DashboardStatsResponse getStats() { 
 
        // ── Users ────────────────────────────────────────── 
        long totalUsers = userRepository.count(); 
 
        // ── Employees ────────────────────────────────────── 
        long totalEmployees = employeeRepository.countByIsDeletedFalse(); 
        long activeEmployees = employeeRepository.countByIsActiveTrue(); 
 
        // ── Projects ─────────────────────────────────────── 
        long totalProjects = projectRepository.countByIsDeletedFalse(); 
 
        ProjectStatus activeStatus = projectStatusRepository 
                .findByStatusNameIgnoreCase("ACTIVE").orElse(null); 
        long activeProjects = activeStatus != null 
                ? projectRepository 
                    .countByFkProjectStatusAndIsDeletedFalse(activeStatus) 
                : 0; 
 
        ProjectStatus completedStatus = projectStatusRepository 
                .findByStatusNameIgnoreCase("COMPLETED").orElse(null); 
        long completedProjects = completedStatus != null 
                ? projectRepository 
                    .countByFkProjectStatusAndIsDeletedFalse(completedStatus) 
                : 0; 
 
        // ── Tasks ────────────────────────────────────────── 
        long totalTasks = taskRepository.countByIsDeletedFalse(); 
 
        long todoTasks = taskRepository 
                .countByFkTaskStatus_StatusNameIgnoreCaseAndIsDeletedFalse("TODO"); 
        long inProgressTasks = taskRepository 
                .countByFkTaskStatus_StatusNameIgnoreCaseAndIsDeletedFalse("IN_PROGRESS"); 
        long doneTasks = taskRepository 
                .countByFkTaskStatus_StatusNameIgnoreCaseAndIsDeletedFalse("DONE"); 
        long blockedTasks = taskRepository 
                .countByFkTaskStatus_StatusNameIgnoreCaseAndIsDeletedFalse("BLOCKED"); 
 
        return DashboardStatsResponse.builder() 
                .totalUsers(totalUsers) 
                .totalEmployees(totalEmployees) 
                .activeEmployees(activeEmployees) 
                .totalProjects(totalProjects) 
                .activeProjects(activeProjects) 
                .completedProjects(completedProjects) 
                .totalTasks(totalTasks) 
                .todoTasks(todoTasks) 
                .inProgressTasks(inProgressTasks) 
                .doneTasks(doneTasks) 
                .blockedTasks(blockedTasks) 
                .build(); 
    } 
} 
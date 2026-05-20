package com.codeaxis.dto;


import lombok.Builder; 
import lombok.Data; 
 
@Data 
@Builder 
public class DashboardStatsResponse { 
 
    // Users 
    private long totalUsers; 
 
    // Employees 
    private long totalEmployees; 
    private long activeEmployees; 
 
    // Projects 
    private long totalProjects; 
    private long activeProjects; 
    private long completedProjects; 
 
    // Tasks 
    private long totalTasks; 
    private long todoTasks; 
    private long inProgressTasks; 
    private long doneTasks; 
    private long blockedTasks; 
} 

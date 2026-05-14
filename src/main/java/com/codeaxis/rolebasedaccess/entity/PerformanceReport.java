package com.codeaxis.rolebasedaccess.entity;

public class PerformanceReport {
    private Long employeeId;
    private int totalTasks;
    private int completedTasks;
    private double performancePercentage;
    private String rating;

    // No-Argument Constructor (Required for JSON)
    public PerformanceReport() {}

    // All-Argument Constructor
    public PerformanceReport(Long employeeId, int totalTasks, int completedTasks, double performancePercentage, String rating) {
        this.employeeId = employeeId;
        this.totalTasks = totalTasks;
        this.completedTasks = completedTasks;
        this.performancePercentage = performancePercentage;
        this.rating = rating;
    }

    // Getters and Setters
    public Long getEmployeeId() { return employeeId; }
    public void setEmployeeId(Long employeeId) { this.employeeId = employeeId; }

    public int getTotalTasks() { return totalTasks; }
    public void setTotalTasks(int totalTasks) { this.totalTasks = totalTasks; }

    public int getCompletedTasks() { return completedTasks; }
    public void setCompletedTasks(int completedTasks) { this.completedTasks = completedTasks; }

    public double getPerformancePercentage() { return performancePercentage; }
    public void setPerformancePercentage(double performancePercentage) { this.performancePercentage = performancePercentage; }

    public String getRating() { return rating; }
    public void setRating(String rating) { this.rating = rating; }
}
package com.codeaxis.rolebasedaccess.entity;

public class Attendance {
    private Long id;
    private Long employeeId;
    private String checkInTime;
    private String checkOutTime;
    private String status;

    // No-Argument Constructor
    public Attendance() {}

    // All-Argument Constructor
    public Attendance(Long id, Long employeeId, String checkInTime, String checkOutTime, String status) {
        this.id = id;
        this.employeeId = employeeId;
        this.checkInTime = checkInTime;
        this.checkOutTime = checkOutTime;
        this.status = status;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getEmployeeId() { return employeeId; }
    public void setEmployeeId(Long employeeId) { this.employeeId = employeeId; }

    public String getCheckInTime() { return checkInTime; }
    public void setCheckInTime(String checkInTime) { this.checkInTime = checkInTime; }

    public String getCheckOutTime() { return checkOutTime; }
    public void setCheckOutTime(String checkOutTime) { this.checkOutTime = checkOutTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
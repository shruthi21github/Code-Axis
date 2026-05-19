package com.codeaxis.rolebasedaccess.dto;

import jakarta.validation.constraints.Size;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

public class EmployeeUpdateDTO {

    private UUID departmentId;
    private UUID designationId;
    private UUID managerEmployeeId;

    @Size(max = 100)
    private String firstName;

    @Size(max = 100)
    private String lastName;

    private LocalDate dateOfBirth;
    private LocalDate joiningDate;
    private BigDecimal salary;
    private Boolean isActive;

    public UUID getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(UUID departmentId) {
        this.departmentId = departmentId;
    }

    public UUID getDesignationId() {
        return designationId;
    }

    public void setDesignationId(UUID designationId) {
        this.designationId = designationId;
    }

    public UUID getManagerEmployeeId() {
        return managerEmployeeId;
    }

    public void setManagerEmployeeId(UUID managerEmployeeId) {
        this.managerEmployeeId = managerEmployeeId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public LocalDate getJoiningDate() {
        return joiningDate;
    }

    public void setJoiningDate(LocalDate joiningDate) {
        this.joiningDate = joiningDate;
    }

    public BigDecimal getSalary() {
        return salary;
    }

    public void setSalary(BigDecimal salary) {
        this.salary = salary;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean active) {
        isActive = active;
    }
}
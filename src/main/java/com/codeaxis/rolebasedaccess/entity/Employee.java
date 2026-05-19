package com.codeaxis.rolebasedaccess.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "employees")

@AttributeOverride(
        name = "id",
        column = @Column(
                name = "pk_employee_id",
                columnDefinition = "BINARY(16)"
        )
)
public class Employee extends BaseEntity {

    @Column(name = "fk_user_id")
    private UUID userId;

    @Column(name = "fk_department_id")
    private UUID departmentId;

    @Column(name = "fk_designation_id")
    private UUID designationId;

    @Column(name = "fk_manager_employee_id")
    private UUID managerEmployeeId;

    @Column(name = "employee_code", unique = true)
    private String employeeCode;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "date_of_birth")
    private LocalDate dateOfBirth;

    @Column(name = "joining_date")
    private LocalDate joiningDate;

    @Column(name = "salary", precision = 15, scale = 2)
    private BigDecimal salary;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "is_deleted")
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;

    // USER ID

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    // DEPARTMENT ID

    public UUID getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(UUID departmentId) {
        this.departmentId = departmentId;
    }

    // DESIGNATION ID

    public UUID getDesignationId() {
        return designationId;
    }

    public void setDesignationId(UUID designationId) {
        this.designationId = designationId;
    }

    // MANAGER EMPLOYEE ID

    public UUID getManagerEmployeeId() {
        return managerEmployeeId;
    }

    public void setManagerEmployeeId(
            UUID managerEmployeeId) {

        this.managerEmployeeId =
                managerEmployeeId;
    }

    // EMPLOYEE CODE

    public String getEmployeeCode() {
        return employeeCode;
    }

    public void setEmployeeCode(
            String employeeCode) {

        this.employeeCode = employeeCode;
    }

    // FIRST NAME

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(
            String firstName) {

        this.firstName = firstName;
    }

    // LAST NAME

    public String getLastName() {
        return lastName;
    }

    public void setLastName(
            String lastName) {

        this.lastName = lastName;
    }

    // DATE OF BIRTH

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(
            LocalDate dateOfBirth) {

        this.dateOfBirth = dateOfBirth;
    }

    // JOINING DATE

    public LocalDate getJoiningDate() {
        return joiningDate;
    }

    public void setJoiningDate(
            LocalDate joiningDate) {

        this.joiningDate = joiningDate;
    }

    // SALARY

    public BigDecimal getSalary() {
        return salary;
    }

    public void setSalary(
            BigDecimal salary) {

        this.salary = salary;
    }

    // IS ACTIVE

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(
            Boolean active) {

        isActive = active;
    }

    // IS DELETED

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(
            Boolean deleted) {

        isDeleted = deleted;
    }

    // DELETED AT

    public LocalDateTime getDeletedAt() {
        return deletedAt;
    }

    public void setDeletedAt(
            LocalDateTime deletedAt) {

        this.deletedAt = deletedAt;
    }
}
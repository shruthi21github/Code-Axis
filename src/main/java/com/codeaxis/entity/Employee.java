package com.codeaxis.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "employees")
@Data
public class Employee {

    @Id
    @Column(name = "pk_employee_id",
            columnDefinition = "binary(16)",
            updatable = false,
            nullable = false)
    private UUID pkEmployeeId;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "fk_user_id",
               columnDefinition = "binary(16)",
               nullable = false)
    private User fkUser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "fk_department_id",
               columnDefinition = "binary(16)",
               nullable = false)
    private Department fkDepartment;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "fk_designation_id",
               columnDefinition = "binary(16)",
               nullable = false)
    private Designation fkDesignation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "fk_manager_employee_id",
               columnDefinition = "binary(16)")
    private Employee fkManagerEmployee;

    @Column(name = "employee_code",
            nullable = false, unique = true)
    private String employeeCode;

    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name", nullable = false)
    private String lastName;

    @Column(name = "date_of_birth")
    private LocalDate dateOfBirth;

    @Column(name = "joining_date", nullable = false)
    private LocalDate joiningDate;

    @Column(name = "salary",
            precision = 15, scale = 2)
    private BigDecimal salary;

    @Column(name = "is_active", nullable = false)
    private boolean isActive = true;

    @Column(name = "is_deleted", nullable = false)
    private boolean isDeleted = false;

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "created_by",
            columnDefinition = "binary(16)")
    private UUID createdBy;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @Column(name = "updated_by",
            columnDefinition = "binary(16)")
    private UUID updatedBy;

    @PrePersist
    protected void onCreate() {
        if (this.pkEmployeeId == null)
            this.pkEmployeeId = UUID.randomUUID();
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
}
package com.codeaxis.service;

import com.codeaxis.dto.EmployeeUpdateDTO;

import com.codeaxis.entity.Department;
import com.codeaxis.entity.Designation;
import com.codeaxis.entity.Employee;

import com.codeaxis.exception.ResourceNotFoundException;

import com.codeaxis.repository.DepartmentRepository;
import com.codeaxis.repository.DesignationRepository;
import com.codeaxis.repository.EmployeeRepository;

import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class EmployeeService {

    private final EmployeeRepository employeeRepository;

    private final DepartmentRepository departmentRepository;

    private final DesignationRepository designationRepository;

    public EmployeeService(

            EmployeeRepository employeeRepository,

            DepartmentRepository departmentRepository,

            DesignationRepository designationRepository) {

        this.employeeRepository = employeeRepository;

        this.departmentRepository = departmentRepository;

        this.designationRepository = designationRepository;
    }

    /*
     * ===============================================================
     * UPDATE EMPLOYEE
     * ===============================================================
     */

    public Employee updateEmployee(
            UUID id,
            EmployeeUpdateDTO dto) {

        Employee employee =
                employeeRepository.findById(id)
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Employee not found"));

        /*
         * ===========================================================
         * UPDATE DEPARTMENT
         * ===========================================================
         */

        if (dto.getDepartmentId() != null) {

            Department department =
                    departmentRepository.findById(
                                    dto.getDepartmentId())
                            .orElseThrow(() ->
                                    new ResourceNotFoundException(
                                            "Department not found"));

            employee.setFkDepartment(department);
        }

        /*
         * ===========================================================
         * UPDATE DESIGNATION
         * ===========================================================
         */

        if (dto.getDesignationId() != null) {

            Designation designation =
                    designationRepository.findById(
                                    dto.getDesignationId())
                            .orElseThrow(() ->
                                    new ResourceNotFoundException(
                                            "Designation not found"));

            employee.setFkDesignation(designation);
        }

        /*
         * ===========================================================
         * UPDATE MANAGER
         * ===========================================================
         */

        if (dto.getManagerEmployeeId() != null) {

            Employee manager =
                    employeeRepository.findById(
                                    dto.getManagerEmployeeId())
                            .orElseThrow(() ->
                                    new ResourceNotFoundException(
                                            "Manager not found"));

            employee.setFkManagerEmployee(manager);
        }

        /*
         * ===========================================================
         * UPDATE BASIC FIELDS
         * ===========================================================
         */

        if (dto.getFirstName() != null) {
            employee.setFirstName(
                    dto.getFirstName());
        }

        if (dto.getLastName() != null) {
            employee.setLastName(
                    dto.getLastName());
        }

        if (dto.getDateOfBirth() != null) {
            employee.setDateOfBirth(
                    dto.getDateOfBirth());
        }

        if (dto.getJoiningDate() != null) {
            employee.setJoiningDate(
                    dto.getJoiningDate());
        }

        if (dto.getSalary() != null) {
            employee.setSalary(
                    dto.getSalary());
        }

        /*
         * ===========================================================
         * UPDATE ACTIVE STATUS
         * ===========================================================
         */

        if (dto.getIsActive() != null) {

            employee.setActive(
                    dto.getIsActive());
        }

        return employeeRepository.save(employee);
    }

    /*
     * ===============================================================
     * DELETE EMPLOYEE
     * ===============================================================
     */

    public String deleteEmployee(UUID id) {

        Employee employee =
                employeeRepository.findById(id)
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Employee not found"));

        employee.setDeleted(true);

        employeeRepository.save(employee);

        return "Employee deleted successfully";
    }
}
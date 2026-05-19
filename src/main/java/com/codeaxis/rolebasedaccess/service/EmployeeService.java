package com.codeaxis.rolebasedaccess.service;

import com.codeaxis.rolebasedaccess.dto.EmployeeUpdateDTO;
import com.codeaxis.rolebasedaccess.entity.Employee;
import com.codeaxis.rolebasedaccess.exception.ResourceNotFoundException;
import com.codeaxis.rolebasedaccess.repository.EmployeeRepository;

import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class EmployeeService {

    private final EmployeeRepository employeeRepository;

    public EmployeeService(
            EmployeeRepository employeeRepository) {

        this.employeeRepository = employeeRepository;
    }

    // UPDATE EMPLOYEE

    public Employee updateEmployee(
            UUID id,
            EmployeeUpdateDTO dto) {

        Employee employee =
                employeeRepository.findById(id)
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Employee not found"));

        if (dto.getDepartmentId() != null) {
            employee.setDepartmentId(
                    dto.getDepartmentId());
        }

        if (dto.getDesignationId() != null) {
            employee.setDesignationId(
                    dto.getDesignationId());
        }

        if (dto.getManagerEmployeeId() != null) {
            employee.setManagerEmployeeId(
                    dto.getManagerEmployeeId());
        }

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

        if (dto.getIsActive() != null) {
            employee.setIsActive(
                    dto.getIsActive());
        }

        return employeeRepository.save(employee);
    }

    // DELETE EMPLOYEE

    public String deleteEmployee(UUID id) {

        Employee employee =
                employeeRepository.findById(id)
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Employee not found"));

        employee.setIsDeleted(true);

        employeeRepository.save(employee);

        return "Employee deleted successfully";
    }
}
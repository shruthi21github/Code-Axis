package com.codeaxis.controller;

import com.codeaxis.dto.EmployeeUpdateDTO;
import com.codeaxis.entity.Employee;
import com.codeaxis.service.EmployeeService;

import jakarta.validation.Valid;

import org.springframework.http.ResponseEntity;

import org.springframework.security.access.prepost.PreAuthorize;

import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/employees")
public class EmployeeController {

    private final EmployeeService employeeService;

    public EmployeeController(
            EmployeeService employeeService) {

        this.employeeService = employeeService;
    }

    // UPDATE EMPLOYEE

    @PutMapping("/{id}")

    @PreAuthorize(
            "hasAuthority('employees.update')")

    public ResponseEntity<?> updateEmployee(

            @PathVariable UUID id,

            @Valid
            @RequestBody EmployeeUpdateDTO dto) {

        Employee employee =
                employeeService.updateEmployee(
                        id,
                        dto);

        return ResponseEntity.ok(
                Map.of(

                        "message",
                        "Employee updated successfully",

                        "data",
                        employee
                ));
    }

    // DELETE EMPLOYEE

    @DeleteMapping("/{id}")

    @PreAuthorize(
            "hasAuthority('employees.delete')")

    public ResponseEntity<?> deleteEmployee(
            @PathVariable UUID id) {

        return ResponseEntity.ok(
                Map.of(

                        "message",

                        employeeService.deleteEmployee(id)
                ));
    }
}
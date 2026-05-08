package com.codeaxis.controller;

import com.codeaxis.dto.EmployeeRequestdto;
import com.codeaxis.service.EmployeeService;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/employees")
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @PostMapping
    public ResponseEntity<?> createEmployee(
            @RequestBody EmployeeRequestdto dto
    ) {

        return ResponseEntity.ok(
                employeeService.createEmployee(dto)
        );
    }

    @GetMapping
    public ResponseEntity<?> getEmployees() {

        return ResponseEntity.ok(
                employeeService.getEmployees()
        );
    }
}
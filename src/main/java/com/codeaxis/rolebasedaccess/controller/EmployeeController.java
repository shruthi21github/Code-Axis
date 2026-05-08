package com.codeaxis.rolebasedaccess.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codeaxis.rolebasedaccess.dto.EmployeeUpdateDTO;
import com.codeaxis.rolebasedaccess.entity.Employee;
import com.codeaxis.rolebasedaccess.service.EmployeeService;

@RestController
@RequestMapping("/api/employees") 
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService; 

    @PostMapping 
    public ResponseEntity<?> create(@RequestBody Employee employee) {
        return employeeService.createEmployee(employee);
    }

    @PutMapping("/{id}") 
    @PreAuthorize("hasAnyRole('ADMIN', 'EMPLOYEE', 'CLIENT')") 
    public ResponseEntity<?> update(@PathVariable Long id, @RequestBody EmployeeUpdateDTO dto) {
        return employeeService.updateEmployee(id, dto);
    }

    @DeleteMapping("/{id}") 
    @PreAuthorize("hasRole('ADMIN')") 
    public ResponseEntity<?> delete(@PathVariable Long id) {
        return employeeService.deleteEmployee(id);
    }
}
package com.codeaxis.rolebasedaccess.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.codeaxis.rolebasedaccess.dto.EmployeeUpdateDTO;
import com.codeaxis.rolebasedaccess.entity.Employee;
import com.codeaxis.rolebasedaccess.repository.EmployeeRepository;

import java.util.HashMap;
import java.util.Map;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    // Logic for Create API 
public ResponseEntity<?> createEmployee(Employee employee) {
    employeeRepository.save(employee);
    return ResponseEntity.ok(formatResponse(true, "Employee created successfully", null));
}

    // Logic for Update API 
    public ResponseEntity<?> updateEmployee(Long id, EmployeeUpdateDTO dto) {
        return employeeRepository.findById(id).map(emp -> {
            emp.setName(dto.getName());
            emp.setDesignation(dto.getDesignation());
            emp.setDepartment(dto.getDepartment());
            emp.setEmail(dto.getEmail());
            employeeRepository.save(emp);
            return ResponseEntity.ok(formatResponse(true, "Employee updated successfully", null));
        }).orElse(ResponseEntity.status(404).body(formatResponse(false, "Employee not found", null)));
    }

    // Logic for Delete API
    public ResponseEntity<?> deleteEmployee(Long id) {
        if (employeeRepository.existsById(id)) {
            employeeRepository.deleteById(id);
            return ResponseEntity.ok(formatResponse(true, "Employee deleted successfully", null));
        }
        return ResponseEntity.status(404).body(formatResponse(false, "Employee not found", null));
    }

    // Standard API Response Format
    private Map<String, Object> formatResponse(boolean status, String message, Object data) {
        Map<String, Object> response = new HashMap<>();
        response.put("status", status);
        response.put("message", message);
        response.put("data", data);
        return response;
    }
}
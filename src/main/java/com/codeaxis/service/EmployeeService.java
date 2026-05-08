package com.codeaxis.service;

import com.codeaxis.dto.EmployeeRequestdto;
import com.codeaxis.entity.Employee;

import java.util.List;

public interface EmployeeService {

    Employee createEmployee(EmployeeRequestdto dto);

    List<Employee> getEmployees();
}
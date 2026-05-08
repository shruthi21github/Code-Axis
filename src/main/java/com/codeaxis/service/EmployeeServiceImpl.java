package com.codeaxis.service;

import com.codeaxis.dto.EmployeeRequestdto;
import com.codeaxis.entity.Employee;
import com.codeaxis.entity.User;
import com.codeaxis.repository.EmployeeRepository;
import com.codeaxis.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private UserRepository userRepository;

    private BCryptPasswordEncoder encoder =
            new BCryptPasswordEncoder();

    @Override
    public Employee createEmployee(
            EmployeeRequestdto dto
    ) {

        List<Employee> employees =
                employeeRepository.getEmployees();

        Employee employee =
                new Employee();

        employee.setId(
                (long) (employees.size() + 1)
        );

        employee.setFullName(
                dto.getFullName()
        );

        employee.setPhone(
                dto.getPhone()
        );

        employee.setDepartment(
                dto.getDepartment()
        );

        employee.setDesignation(
                dto.getDesignation()
        );

        employee.setUsername(
                dto.getUsername()
        );

        employees.add(employee);

        employeeRepository
                .saveEmployees(employees);

        List<User> users =
                userRepository.getUsers();

        User user =
                new User();

        user.setUsername(
                dto.getUsername()
        );

        user.setPassword(
                encoder.encode(
                        dto.getPassword()
                )
        );

        user.setRole("EMPLOYEE");

        users.add(user);

        userRepository.saveUsers(users);

        return employee;
    }

    @Override
    public List<Employee> getEmployees() {

        return employeeRepository.getEmployees();
    }
}
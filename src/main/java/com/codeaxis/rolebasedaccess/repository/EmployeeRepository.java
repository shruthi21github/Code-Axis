package com.codeaxis.rolebasedaccess.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.codeaxis.rolebasedaccess.entity.Employee;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Long> {
    // Inherits save(), findById(), deleteById(), and existsById() automatically.
}
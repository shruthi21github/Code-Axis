package com.codeaxis.repository;

import com.codeaxis.entity.Employee;
import java.io.File;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Repository;

import java.io.InputStream;
import java.util.List;

@Repository
public class EmployeeRepository {

    public List<Employee> getEmployees() {

        try {

            ObjectMapper mapper =
                    new ObjectMapper();

            InputStream inputStream =
                    new ClassPathResource(
                            "employees.json"
                    ).getInputStream();

            return mapper.readValue(
                    inputStream,
                    new TypeReference<List<Employee>>() {}
            );

        } catch (Exception e) {

            throw new RuntimeException(e);
        }
    }
    

    public void saveEmployees(
        List<Employee> employees
) {

    try {

        ObjectMapper mapper =
                new ObjectMapper();

        File file = new File(
                "src/main/resources/employees.json"
        );

        mapper.writeValue(file, employees);

    } catch (Exception e) {

        throw new RuntimeException(e);
    }
}
}
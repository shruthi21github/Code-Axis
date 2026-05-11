package com.codeaxis.service.impl;

import com.codeaxis.entity.Student;
import com.codeaxis.service.StudentService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Service
public class StudentServiceImpl
        implements StudentService {

    private final String FILE_PATH =
            "src/main/resources/data/students.json";

    private final ObjectMapper objectMapper =
            new ObjectMapper();

    @Override
    public List<Student> getAllStudents() {

        try {

            File file = new File(FILE_PATH);

            if (!file.exists()) {
                return new ArrayList<>();
            }

            return objectMapper.readValue(
                    file,
                    new TypeReference<List<Student>>() {}
            );

        } catch (Exception e) {

            throw new RuntimeException(
                    "Failed to read students.json");
        }
    }

    @Override
    public boolean studentExists(Long studentId) {

        List<Student> students =
                getAllStudents();

        return students.stream()
                .anyMatch(student ->
                        student.getId()
                                .equals(studentId));
    }
    @Override
public Student getStudentById(Long id) {

    List<Student> students = getAllStudents();

    return students.stream()
            .filter(student ->
                    student.getId().equals(id)
            )
            .findFirst()
            .orElse(null);
}
}
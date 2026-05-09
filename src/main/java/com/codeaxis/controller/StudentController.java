package com.codeaxis.controller;

import com.codeaxis.dto.ApiResponse;
import com.codeaxis.entity.Student;
import com.codeaxis.service.StudentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/students")
@RequiredArgsConstructor
public class StudentController {

    private final StudentService studentService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<Student>>> getStudents() {

        List<Student> students =
                studentService.getAllStudents();

        return ResponseEntity.ok(
                new ApiResponse<>(
                        true,
                        "Students fetched successfully",
                        students
                )
        );
    }
}
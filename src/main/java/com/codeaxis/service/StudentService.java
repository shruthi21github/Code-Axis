package com.codeaxis.service;

import com.codeaxis.entity.Student;

import java.util.List;


public interface StudentService {

    Student getStudentById(Long id);
    List<Student> getAllStudents();

    boolean studentExists(Long studentId);
}
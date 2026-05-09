package com.codeaxis.service;

import com.codeaxis.entity.Student;

import java.util.List;

public interface StudentService {

    List<Student> getAllStudents();

    boolean studentExists(Long studentId);
}
package com.codeaxis.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Student {

    private Long id;

    private String name;

    private String username;

    private String email;

    private String course;

    private String department;
}
package com.codeaxis.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "projects")
@Data
public class Project {
    
    @Id
    @GeneratedValue(strategy = GeneratedType.IDENTITY)
    
    private Long id;
    private String name;
    private String description;
    private String status;

    private LocalDate starDate;
    private LocalDate deadline;
}

package com.codeaxis.dto;

import lombok.Data;
import jakarta.validation.constraints.NotBlank;

@Data
public class ProjectRequest {
    
    @NotBlank
    private String name;
    private String description;
    private String status;
    private String startDate;
    private String deadline;
}

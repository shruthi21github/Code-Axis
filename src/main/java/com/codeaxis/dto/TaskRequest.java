package com.codeaxis.dto;

import lombok.Data;
import jakarta.validation.constraints.NotBlank;

@Data
public class TaskRequest {
    @NotBlank

    private String title;
    private String description;
    private String status;
    private String deadline;
    private Long projectId;  
}

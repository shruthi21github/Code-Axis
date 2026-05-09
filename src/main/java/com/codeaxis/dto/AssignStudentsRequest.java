package com.codeaxis.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
public class AssignStudentsRequest {

    @NotNull(message = "Project ID is required")
    private Long projectId;

    @NotEmpty(message = "Student IDs cannot be empty")
    private List<Long> studentIds;
}
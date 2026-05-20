package com.codeaxis.dto;

import java.math.BigDecimal;
import java.util.UUID;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TaskCreateDTO {

    private UUID projectId;

    private UUID userId;

    private UUID taskStatusId;

    private UUID taskPriorityId;

    private String taskTitle;

    private String taskDescription;

    private BigDecimal estimatedHours;

    private BigDecimal actualHours;

    private Boolean isActive;

    private Boolean isDeleted;
}
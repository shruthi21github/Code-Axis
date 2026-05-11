package com.codeaxis.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TaskResponse {
    private boolean status;
    private String message;
    private Object data;
}

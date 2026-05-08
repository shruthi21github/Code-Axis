package com.codeaxis.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ApiResponse {
    private boolean status;
    private String message;
    private Object data;
}

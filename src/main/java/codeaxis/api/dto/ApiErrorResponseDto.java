package codeaxis.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor

public class ApiErrorResponseDto {

    private Boolean success;

    private String message;

    private Object error;
}

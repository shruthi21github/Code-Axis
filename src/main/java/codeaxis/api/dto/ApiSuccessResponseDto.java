package codeaxis.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@lombok.Builder

public class ApiSuccessResponseDto<T> {

    private Boolean success;

    private String message;

    private T data;
}

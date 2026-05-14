package codeaxis.api.dto;

public class ApiErrorResponseDto {

    private Boolean success;

    private String message;

    private Object error;

    public ApiErrorResponseDto(
            Boolean success,

            String message,

            Object error) {

        this.success = success;

        this.message = message;

        this.error = error;
    }

    public Boolean getSuccess() {
        return success;
    }

    public String getMessage() {
        return message;
    }

    public Object getError() {
        return error;
    }
}

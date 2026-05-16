package codeaxis.api.exception;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.resource.NoResourceFoundException;
import org.springframework.web.ErrorResponseException;

import codeaxis.api.dto.ApiErrorResponseDto;

@RestControllerAdvice
public class GlobalExceptionHandler {

        @ExceptionHandler(ApiException.class)
        public ResponseEntity<ApiErrorResponseDto> handleApiException(
                        ApiException exception) {

                Map<String, Object> error = new LinkedHashMap<>();

                error.put(
                                "code",
                                exception.getStatus().value());

                error.put(
                                "type",
                                exception.getStatus().name());

                ApiErrorResponseDto response = new ApiErrorResponseDto(
                                false,
                                exception.getMessage(),
                                error);

                return ResponseEntity
                                .status(exception.getStatus())
                                .body(response);
        }

        @ExceptionHandler(NoResourceFoundException.class)
        public ResponseEntity<ApiErrorResponseDto> handleNoResourceFoundException(
                        NoResourceFoundException exception) {

                Map<String, Object> error = new LinkedHashMap<>();

                error.put(
                                "code",
                                404);

                error.put(
                                "type",
                                "NOT_FOUND");

                ApiErrorResponseDto response = new ApiErrorResponseDto(
                                false,
                                "Route not found",
                                error);

                return ResponseEntity
                                .status(org.springframework.http.HttpStatus.NOT_FOUND)
                                .body(response);
        }

        @ExceptionHandler(ErrorResponseException.class)
        public ResponseEntity<ApiErrorResponseDto> handleErrorResponseException(
                        ErrorResponseException exception) {

                Map<String, Object> error = new LinkedHashMap<>();

                error.put(
                                "code",
                                exception.getStatusCode().value());

                error.put(
                                "type",
                                exception.getStatusCode().toString());

                ApiErrorResponseDto response = new ApiErrorResponseDto(
                                false,
                                exception.getBody().getDetail(),
                                error);

                return ResponseEntity
                                .status(exception.getStatusCode())
                                .body(response);
        }
}

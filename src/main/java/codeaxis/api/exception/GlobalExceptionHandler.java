package codeaxis.api.exception;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.bind.MethodArgumentNotValidException;
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

        @ExceptionHandler(MethodArgumentNotValidException.class)
        public ResponseEntity<ApiErrorResponseDto> handleMethodArgumentNotValidException(
                        MethodArgumentNotValidException exception) {

                String message = exception.getBindingResult()
                                .getFieldErrors()
                                .stream()
                                .findFirst()
                                .map(fieldError -> fieldError.getDefaultMessage())
                                .orElse("Validation failed");

                Map<String, Object> error = new LinkedHashMap<>();

                error.put(
                                "code",
                                400);

                error.put(
                                "type",
                                "BAD_REQUEST");

                ApiErrorResponseDto response = new ApiErrorResponseDto(
                                false,
                                message,
                                error);

                return ResponseEntity
                                .badRequest()
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

        @ExceptionHandler(Exception.class)
        public ResponseEntity<ApiErrorResponseDto> handleGenericException(
                        Exception exception) {

                int statusCode = 500;

                String statusType = "INTERNAL_SERVER_ERROR";

                String message = "Internal server error";

                /*
                 * ===============================================================
                 * SPRING ERROR RESPONSE EXCEPTION
                 * ===============================================================
                 */

                if (exception instanceof ErrorResponseException ex) {

                        statusCode = ex.getStatusCode()
                                        .value();

                        statusType = ex.getStatusCode()
                                        .toString();

                        if (ex.getBody() != null
                                        && ex.getBody().getDetail() != null
                                        && !ex.getBody().getDetail().isBlank()) {

                                message = ex.getBody()
                                                .getDetail();
                        }
                }

                /*
                 * ===============================================================
                 * CUSTOM API EXCEPTION
                 * ===============================================================
                 */

                else if (exception instanceof ApiException ex) {

                        statusCode = ex.getStatus()
                                        .value();

                        statusType = ex.getStatus()
                                        .name();

                        message = ex.getMessage();
                }

                /*
                 * ===============================================================
                 * GENERIC MESSAGE FALLBACK
                 * ===============================================================
                 */

                else if (exception.getMessage() != null
                                && !exception.getMessage().isBlank()) {

                        message = exception.getMessage();
                }

                Map<String, Object> error = new LinkedHashMap<>();

                error.put(
                                "code",
                                statusCode);

                error.put(
                                "type",
                                statusType);

                ApiErrorResponseDto response = new ApiErrorResponseDto(
                                false,
                                message,
                                error);

                return ResponseEntity
                                .status(statusCode)
                                .body(response);
        }
}

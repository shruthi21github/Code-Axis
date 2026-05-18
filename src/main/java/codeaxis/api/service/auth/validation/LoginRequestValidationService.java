package codeaxis.api.service.auth.validation;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import codeaxis.api.dto.auth.LoginRequestDto;
import codeaxis.api.exception.ApiException;

@Service
public class LoginRequestValidationService {

    public void validate(
            LoginRequestDto requestDto) {

        boolean hasUsername = requestDto.getUsername() != null
                && !requestDto.getUsername().isBlank();

        boolean hasEmail = requestDto.getEmail() != null
                && !requestDto.getEmail().isBlank();

        if (!hasUsername && !hasEmail) {

            throw new ApiException(
                    HttpStatus.BAD_REQUEST,
                    "Username or email is required");
        }
    }
}

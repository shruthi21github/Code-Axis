package com.codeaxis.service.auth.validation;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.codeaxis.dto.auth.LoginRequestDto;
import com.codeaxis.exception.ApiException;

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

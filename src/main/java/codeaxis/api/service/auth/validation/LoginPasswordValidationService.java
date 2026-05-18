package codeaxis.api.service.auth.validation;

import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import codeaxis.api.entity.User;
import codeaxis.api.exception.ApiException;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor

public class LoginPasswordValidationService {

    private final PasswordEncoder passwordEncoder;

    public void validate(
            User user,
            String rawPassword) {

        boolean isPasswordValid = passwordEncoder.matches(
                rawPassword,
                user.getPasswordHash());

        if (!isPasswordValid) {

            throw new ApiException(
                    HttpStatus.UNAUTHORIZED,
                    "Invalid login credentials");
        }
    }
}

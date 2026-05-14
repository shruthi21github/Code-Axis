package codeaxis.api.controller.auth;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import codeaxis.api.dto.ApiSuccessResponseDto;
import codeaxis.api.dto.auth.RegisterRequestDto;
import codeaxis.api.dto.auth.RegisterResponseDto;
import codeaxis.api.service.auth.RegisterService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/auth")
public class RegisterController {

    private final RegisterService registerService;

    public RegisterController(
            RegisterService registerService) {

        this.registerService = registerService;
    }

    @PostMapping("/register")
    @ResponseStatus(HttpStatus.CREATED)
    public ApiSuccessResponseDto<RegisterResponseDto> register(

            @Valid @RequestBody RegisterRequestDto request) {

        RegisterResponseDto response = registerService.register(request);

        return new ApiSuccessResponseDto<>(
                true,
                "User registered successfully",
                response);
    }
}
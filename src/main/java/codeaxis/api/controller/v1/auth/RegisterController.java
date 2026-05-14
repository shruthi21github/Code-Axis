package codeaxis.api.controller.v1.auth;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import codeaxis.api.dto.auth.RegisterRequestDto;
import codeaxis.api.dto.auth.RegisterResponseDto;
import codeaxis.api.service.auth.RegisterService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/v1/auth")
public class RegisterController
{
    private final RegisterService registerService;

    public RegisterController(RegisterService registerService)
    {
        this.registerService = registerService;
    }

    @PostMapping("/register")
    @ResponseStatus(HttpStatus.CREATED)
    public RegisterResponseDto register
    (
        @Valid
        @RequestBody
        RegisterRequestDto request
    )
    {
        return registerService.register(request);
    }
}

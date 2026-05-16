package codeaxis.api.controller.auth;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import codeaxis.api.dto.ApiSuccessResponseDto;
import codeaxis.api.dto.auth.VerifyEmailRequestDto;
import codeaxis.api.dto.auth.VerifyEmailResponseDto;
import codeaxis.api.service.auth.VerifyEmailService;

import jakarta.validation.Valid;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor

public class VerifyEmailController {

        private final VerifyEmailService verifyEmailService;

        @PostMapping("/verify-email")
        @ResponseStatus(HttpStatus.OK)
        public ApiSuccessResponseDto<VerifyEmailResponseDto> verifyEmail(

                        @Valid @RequestBody VerifyEmailRequestDto request) {

                VerifyEmailResponseDto response = verifyEmailService.verifyEmail(
                                request);

                return new ApiSuccessResponseDto<>(
                                true,
                                "Email verified successfully",
                                response);
        }
}

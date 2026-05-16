package codeaxis.api.controller.auth;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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
@Validated

public class VerifyEmailController {

        private final VerifyEmailService verifyEmailService;

        @PostMapping("/verify-email")
        public ResponseEntity<ApiSuccessResponseDto<VerifyEmailResponseDto>> verifyEmail(

                        @Valid @RequestBody VerifyEmailRequestDto requestDto) {

                VerifyEmailResponseDto responseDto = verifyEmailService.verifyEmail(
                                requestDto);

                ApiSuccessResponseDto<VerifyEmailResponseDto> response = ApiSuccessResponseDto
                                .<VerifyEmailResponseDto>builder()
                                .success(
                                                true)
                                .message(
                                                "Email verified successfully")
                                .data(
                                                responseDto)
                                .build();

                return ResponseEntity
                                .status(
                                                HttpStatus.OK)
                                .body(
                                                response);
        }
}

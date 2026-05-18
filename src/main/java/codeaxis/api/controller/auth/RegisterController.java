package codeaxis.api.controller.auth;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import codeaxis.api.dto.ApiSuccessResponseDto;
import codeaxis.api.dto.auth.RegisterRequestDto;
import codeaxis.api.dto.auth.RegisterResponseDto;
import codeaxis.api.service.auth.RegisterService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Validated

public class RegisterController {

        private final RegisterService registerService;

        @PostMapping("/register")
        public ResponseEntity<ApiSuccessResponseDto<RegisterResponseDto>> register(

                        @Valid @RequestBody RegisterRequestDto requestDto) {

                RegisterResponseDto responseDto = registerService.register(
                                requestDto);

                ApiSuccessResponseDto<RegisterResponseDto> response = ApiSuccessResponseDto
                                .<RegisterResponseDto>builder()
                                .success(
                                                true)
                                .message(
                                                "User registered successfully")
                                .data(
                                                responseDto)
                                .build();

                return ResponseEntity
                                .status(
                                                HttpStatus.CREATED)
                                .body(
                                                response);
        }
}

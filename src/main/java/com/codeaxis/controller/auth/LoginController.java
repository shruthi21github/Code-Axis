package com.codeaxis.controller.auth;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codeaxis.dto.ApiSuccessResponseDto;
import com.codeaxis.dto.auth.LoginRequestDto;
import com.codeaxis.dto.auth.LoginResponseDto;
import com.codeaxis.service.auth.LoginService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Validated

public class LoginController {

        private final LoginService loginService;

        @PostMapping("/login")
        public ResponseEntity<ApiSuccessResponseDto<LoginResponseDto>> login(
                        @Valid @RequestBody LoginRequestDto requestDto) {

                LoginResponseDto responseDto = loginService.login(
                                requestDto);

                ApiSuccessResponseDto<LoginResponseDto> response = ApiSuccessResponseDto.<LoginResponseDto>builder()
                                .success(
                                                true)
                                .message(
                                                "Login successful")
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

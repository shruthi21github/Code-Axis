package com.codeaxis.controller.auth;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import com.codeaxis.dto.ApiSuccessResponseDto;
import com.codeaxis.dto.RefreshTokenRequest;
import com.codeaxis.dto.RefreshTokenResponse;
import com.codeaxis.service.auth.RefreshTokenService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Validated
public class RefreshController {

        private final RefreshTokenService refreshTokenService;

        @PostMapping("/refresh-token")
        public ResponseEntity<ApiSuccessResponseDto<RefreshTokenResponse>> refreshToken(
                        @Valid @RequestBody RefreshTokenRequest request) {

                RefreshTokenResponse responseDto = refreshTokenService.refreshAccessToken(request.getRefreshToken());

                ApiSuccessResponseDto<RefreshTokenResponse> response = ApiSuccessResponseDto
                                .<RefreshTokenResponse>builder()
                                .success(true)
                                .message("Token refreshed successfully")
                                .data(responseDto)
                                .build();

                return ResponseEntity
                                .status(HttpStatus.OK)
                                .body(response);
        }
}
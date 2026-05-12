package com.codeaxis.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codeaxis.dto.RefreshTokenResponse;
import com.codeaxis.dto.RefreshTokenRequest;
import com.codeaxis.dto.ApiResponse;
import com.codeaxis.service.RefreshTokenService;
import lombok.RequiredArgsConstructor;
import jakarta.validation.Valid;;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
    public class AuthController {

    private final RefreshTokenService refreshTokenService;

    @PostMapping("/refresh-token")
    public ResponseEntity<?> refreshToken(@Valid @RequestBody RefreshTokenRequest request) {
        String newAccessToken = refreshTokenService.refreshAccessToken(request.getRefreshToken());

        return ResponseEntity.ok(ApiResponse.builder()
                .status(true)
                .message("Token refreshed successfully")
                .data(new RefreshTokenResponse(newAccessToken, "Bearer"))
                .build());
    }
}
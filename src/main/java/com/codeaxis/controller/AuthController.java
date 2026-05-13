package com.codeaxis.controller;

import com.codeaxis.dto.RefreshTokenRequest;
import com.codeaxis.dto.RefreshTokenResponse;
import com.codeaxis.service.RefreshTokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final RefreshTokenService
        refreshTokenService;

    @PostMapping("/refresh-token")
    public ResponseEntity<RefreshTokenResponse>
            refreshToken(
        @RequestBody RefreshTokenRequest request) {

        String newToken = refreshTokenService
            .refreshAccessToken(
                request.getRefreshToken());

        return ResponseEntity.ok(
            new RefreshTokenResponse(
                true,
                "Token refreshed successfully",
                newToken,
                "Bearer"
            )
        );
    }
}
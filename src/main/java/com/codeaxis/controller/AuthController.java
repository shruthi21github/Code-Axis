package com.codeaxis.controller; 
 
import com.codeaxis.dto.RefreshTokenRequest; 
import com.codeaxis.dto.ApiResponse; 
import com.codeaxis.dto.RefreshTokenResponse; 
import com.codeaxis.service.RefreshTokenService; 
import jakarta.validation.Valid; 
import lombok.RequiredArgsConstructor; 
import org.springframework.http.ResponseEntity; 
import org.springframework.web.bind.annotation.*; 
 
@RestController 
@RequestMapping("/api/auth") 
@RequiredArgsConstructor 
public class AuthController { 
 
    private final RefreshTokenService refreshTokenService; 
 
    @PostMapping("/refresh-token") 
    public ResponseEntity<?> refreshToken( 
            @Valid @RequestBody RefreshTokenRequest request) { 
 
        String userEmail = refreshTokenService 
                .refreshAccessToken(request.getRefreshToken()); 
 
        // Plug JwtUtils.generateToken(userEmail) here when ready 
        String newAccessToken = "Bearer-JWT-for-" + userEmail; 
 
        return ResponseEntity.ok(ApiResponse.builder() 
                .status(true) 
                .message("Token refreshed successfully") 
                .data(new RefreshTokenResponse(newAccessToken, "Bearer")) 
                .build()); 
    } 
} 

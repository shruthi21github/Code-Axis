package com.codeaxis.dto;

import lombok.Data;

@Data
public class RefreshTokenRequest {
    @NotBlank(message = "Refresh token must not be blank")
    private String refreshToken;
}

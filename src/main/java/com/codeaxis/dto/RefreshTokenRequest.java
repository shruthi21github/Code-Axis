package com.codeaxis.dto;

import lombok.Data;
import jakarta.validation.constraints.NotBlank;


@Data
public class RefreshTokenRequest {
    @NotBlank(message = "Refresh token must not be blank")
    private String refreshToken;
}

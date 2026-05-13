package com.codeaxis.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RefreshTokenResponse {
    private boolean status;
    private String message;
    private String accessToken;
    private String tokenType = "Bearer";
}

package com.codeaxis.dto;

public class LoginResponse {

    private boolean status;
    private String message;
    private String token;
    private String role;

    public LoginResponse(
            boolean status,
            String message,
            String token,
            String role
    ) {
        this.status = status;
        this.message = message;
        this.token = token;
        this.role = role;
    }

    public boolean isStatus() {
        return status;
    }

    public String getMessage() {
        return message;
    }

    public String getToken() {
        return token;
    }

    public String getRole() {
        return role;
    }
}
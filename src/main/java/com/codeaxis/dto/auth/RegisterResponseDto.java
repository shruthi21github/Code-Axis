package com.codeaxis.dto.auth;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class RegisterResponseDto {

    private String userId;

    private String roleId;

    private String username;

    private String email;

    private String roleName;

    private Boolean isEmailVerified;

    private Boolean isActive;

    private LocalDateTime createdAt;
}

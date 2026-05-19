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

public class VerifyEmailResponseDto {

    private String userId;

    private String email;

    private Boolean isEmailVerified;

    private LocalDateTime emailVerifiedAt;
}

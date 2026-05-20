package com.codeaxis.service.auth.mapper;

import org.springframework.stereotype.Service;

import com.codeaxis.dto.auth.VerifyEmailResponseDto;
import com.codeaxis.entity.User;

@Service

public class VerifyEmailResponseMapper {

    public VerifyEmailResponseDto mapToResponse(
            User user) {

        return VerifyEmailResponseDto.builder()

                .userId(
                        user.getPkUserId().toString())

                .email(
                        user.getEmail())

                .isEmailVerified(
                        user.getIsEmailVerified())

                .emailVerifiedAt(
                        user.getEmailVerifiedAt())

                .build();
    }
}

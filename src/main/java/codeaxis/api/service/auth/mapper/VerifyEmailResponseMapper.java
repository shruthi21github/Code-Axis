package codeaxis.api.service.auth.mapper;

import org.springframework.stereotype.Service;

import codeaxis.api.dto.auth.VerifyEmailResponseDto;
import codeaxis.api.entity.User;

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

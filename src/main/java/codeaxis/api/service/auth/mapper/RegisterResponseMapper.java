package codeaxis.api.service.auth.mapper;

import org.springframework.stereotype.Component;

import codeaxis.api.dto.auth.RegisterResponseDto;
import codeaxis.api.entity.User;

@Component
public class RegisterResponseMapper {

        public RegisterResponseDto mapToResponse(
                        User user) {

                return RegisterResponseDto.builder()
                                .userId(
                                                user.getPkUserId().toString())
                                .roleId(
                                                user.getFkRoleId()
                                                                .getPkRoleId()
                                                                .toString())
                                .username(
                                                user.getUsername())
                                .email(
                                                user.getEmail())
                                .roleName(
                                                user.getFkRoleId()
                                                                .getRoleName())
                                .isEmailVerified(
                                                user.getIsEmailVerified())
                                .isActive(
                                                user.getIsActive())
                                .createdAt(
                                                user.getCreatedAt())
                                .build();
        }
}

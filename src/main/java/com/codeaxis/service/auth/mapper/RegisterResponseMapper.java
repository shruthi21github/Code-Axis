package com.codeaxis.service.auth.mapper;

import org.springframework.stereotype.Component;

import com.codeaxis.dto.auth.RegisterResponseDto;
import com.codeaxis.entity.User;

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

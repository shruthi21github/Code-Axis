package codeaxis.api.service.auth.mapper;

import org.springframework.stereotype.Component;

import codeaxis.api.dto.auth.RegisterResponseDto;
import codeaxis.api.entity.User;

@Component
public class RegisterResponseMapper {

        public RegisterResponseDto mapToResponse(
                        User user) {

                RegisterResponseDto response = new RegisterResponseDto();

                response.setUserId(
                                user.getPkUserId().toString());

                response.setRoleId(
                                user.getFkRoleId()
                                                .getPkRoleId()
                                                .toString());

                response.setUsername(
                                user.getUsername());

                response.setEmail(
                                user.getEmail());

                response.setRoleName(
                                user.getFkRoleId()
                                                .getRoleName());

                response.setIsEmailVerified(
                                user.getIsEmailVerified());

                response.setIsActive(
                                user.getIsActive());

                response.setCreatedAt(
                                user.getCreatedAt());

                return response;
        }
}

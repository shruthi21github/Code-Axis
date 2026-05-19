package com.codeaxis.service.auth.factory;

import org.springframework.stereotype.Component;

import com.codeaxis.dto.auth.LoginResponseDto;

@Component
public class LoginResponseFactory {

        public LoginResponseDto create(
                        String accessToken,
                        String refreshToken) {

                return LoginResponseDto.builder()
                                .accessToken(
                                                accessToken)
                                .refreshToken(
                                                refreshToken)
                                .build();
        }
}

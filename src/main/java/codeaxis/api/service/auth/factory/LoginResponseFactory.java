package codeaxis.api.service.auth.factory;

import org.springframework.stereotype.Component;

import codeaxis.api.dto.auth.LoginResponseDto;

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

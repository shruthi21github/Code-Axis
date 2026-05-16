package codeaxis.api.service.auth.dto;

import codeaxis.api.entity.EmailVerificationToken;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor

public class EmailVerificationTokenResult {

        private final String rawToken;

        private final EmailVerificationToken emailVerificationToken;
}

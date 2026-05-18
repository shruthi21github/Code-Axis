package com.codeaxis.service.auth.dto;

import com.codeaxis.entity.EmailVerificationToken;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor

public class EmailVerificationTokenResult {

        private final String rawToken;

        private final EmailVerificationToken emailVerificationToken;
}

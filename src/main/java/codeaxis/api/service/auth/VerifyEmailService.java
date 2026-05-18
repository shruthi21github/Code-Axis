package codeaxis.api.service.auth;

import java.time.LocalDateTime;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import codeaxis.api.dto.auth.VerifyEmailRequestDto;
import codeaxis.api.dto.auth.VerifyEmailResponseDto;
import codeaxis.api.entity.EmailVerificationToken;
import codeaxis.api.entity.User;
import codeaxis.api.service.auth.mapper.VerifyEmailResponseMapper;
import codeaxis.api.service.auth.validation.VerifyEmailValidationService;
import codeaxis.api.utils.Sha256Util;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor

public class VerifyEmailService {

        private final VerifyEmailValidationService verifyEmailValidationService;

        private final VerifyEmailResponseMapper verifyEmailResponseMapper;

        @Transactional
        public VerifyEmailResponseDto verifyEmail(
                        VerifyEmailRequestDto request) {

                /*
                 * =======================================================================
                 * HASH RAW TOKEN
                 * =======================================================================
                 */

                String tokenHash = Sha256Util.hash(
                                request.getToken());

                /*
                 * =======================================================================
                 * VALIDATE TOKEN
                 * =======================================================================
                 */

                EmailVerificationToken token = verifyEmailValidationService
                                .validateAndGetToken(
                                                tokenHash);

                /*
                 * =======================================================================
                 * LOAD USER
                 * =======================================================================
                 */

                User user = token.getFkUserId();

                /*
                 * =======================================================================
                 * VALIDATE USER EMAIL STATUS
                 * =======================================================================
                 */

                verifyEmailValidationService
                                .validateUserNotAlreadyVerified(
                                                user);

                /*
                 * =======================================================================
                 * VERIFY EMAIL
                 * =======================================================================
                 */

                user.setIsEmailVerified(true);

                user.setEmailVerifiedAt(
                                LocalDateTime.now());

                /*
                 * =======================================================================
                 * DEACTIVATE TOKEN
                 * =======================================================================
                 */

                token.setIsActive(false);

                token.setVerifiedAt(
                                LocalDateTime.now());

                /*
                 * =======================================================================
                 * BUILD RESPONSE
                 * =======================================================================
                 */

                return verifyEmailResponseMapper
                                .mapToResponse(
                                                user);
        }
}

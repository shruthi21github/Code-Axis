package com.codeaxis.service.auth.factory;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;

import com.codeaxis.entity.EmailVerificationToken;
import com.codeaxis.entity.User;
import com.codeaxis.service.auth.dto.EmailVerificationTokenResult;
import com.codeaxis.utils.Sha256Util;
import com.github.f4b6a3.uuid.UuidCreator;

@Component
public class EmailVerificationTokenFactory {

        public EmailVerificationTokenResult createToken(
                        User user) {

                /*
                 * ===========================================================================
                 * GENERATE RAW VERIFICATION TOKEN
                 * ===========================================================================
                 */

                String rawVerificationToken = UuidCreator.getTimeOrderedEpoch()
                                .toString();

                /*
                 * ===========================================================================
                 * HASH VERIFICATION TOKEN
                 * ===========================================================================
                 */

                String verificationTokenHash = Sha256Util.hash(
                                rawVerificationToken);

                /*
                 * ===========================================================================
                 * CREATE TOKEN ENTITY
                 * ===========================================================================
                 */

                EmailVerificationToken token = EmailVerificationToken.builder()

                                .pkEmailVerificationTokenId(
                                                UuidCreator.getTimeOrderedEpoch())

                                .fkUserId(
                                                user)

                                .verificationTokenHash(
                                                verificationTokenHash)

                                .expiresAt(
                                                LocalDateTime.now()
                                                                .plusHours(24))

                                .isActive(
                                                true)

                                .createdAt(
                                                LocalDateTime.now())

                                .build();

                /*
                 * ===========================================================================
                 * RETURN RAW TOKEN + ENTITY
                 * ===========================================================================
                 */

                return new EmailVerificationTokenResult(
                                rawVerificationToken,
                                token);
        }
}

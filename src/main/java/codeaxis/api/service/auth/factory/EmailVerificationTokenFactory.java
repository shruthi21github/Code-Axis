package codeaxis.api.service.auth.factory;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;

import com.github.f4b6a3.uuid.UuidCreator;

import codeaxis.api.entity.EmailVerificationToken;
import codeaxis.api.entity.User;
import codeaxis.api.service.auth.dto.EmailVerificationTokenResult;
import codeaxis.api.utils.Sha256Util;

@Component
public class EmailVerificationTokenFactory {

        public EmailVerificationTokenResult createToken(
                        User user) {

                /*
                 * ===========================================================================
                 * GENERATE RAW VERIFICATION TOKEN
                 * ===========================================================================
                 */

                String rawVerificationToken = UuidCreator
                                .getTimeOrderedEpoch()
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
                 * CREATE EMAIL VERIFICATION TOKEN ENTITY
                 * ===========================================================================
                 */

                EmailVerificationToken token = new EmailVerificationToken();
                token.setPkEmailVerificationTokenId(
                                UuidCreator.getTimeOrderedEpoch());

                token.setFkUserId(user);

                token.setVerificationTokenHash(
                                verificationTokenHash);

                token.setExpiresAt(
                                LocalDateTime.now()
                                                .plusHours(24));

                token.setIsActive(true);

                token.setCreatedAt(
                                LocalDateTime.now());

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

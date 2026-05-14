package codeaxis.api.service.auth.factory;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;

import com.github.f4b6a3.uuid.UuidCreator;

import codeaxis.api.entity.EmailVerificationToken;
import codeaxis.api.entity.User;
import codeaxis.api.utils.Sha256Util;

@Component
public class EmailVerificationTokenFactory {

        public EmailVerificationToken createToken(
                        User user) {

                String rawVerificationToken = UuidCreator
                                .getTimeOrderedEpoch()
                                .toString();

                String verificationTokenHash = Sha256Util.hash(
                                rawVerificationToken);
                /*
                 * =======================================================================
                 * CREATE EMAIL VERIFICATION TOKEN ENTITY
                 * =======================================================================
                 * 
                 * Table :
                 * email_verification_tokens
                 * 
                 * Purpose :
                 * Stores email verification token linked to registered user.
                 */

                EmailVerificationToken token = new EmailVerificationToken();

                token.setEmailVerificationTokenId(
                                UuidCreator.getTimeOrderedEpoch());

                token.setUser(user);

                token.setVerificationTokenHash(
                                verificationTokenHash);

                token.setExpiresAt(
                                LocalDateTime.now()
                                                .plusHours(24));

                token.setIsActive(true);

                token.setCreatedAt(
                                LocalDateTime.now());

                return token;
        }
}

package com.codeaxis.service.auth.factory;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;

import com.codeaxis.entity.User;
import com.codeaxis.entity.UserSession;
import com.github.f4b6a3.uuid.UuidCreator;

@Component
public class UserSessionFactory {

        public UserSession create(
                        User user,
                        String refreshTokenHash,
                        LocalDateTime refreshTokenExpiresAt) {

                return UserSession.builder()
                                .pkUserSessionId(
                                                UuidCreator.getTimeOrderedEpoch())
                                .fkUserId(
                                                user)
                                .refreshTokenHash(
                                                refreshTokenHash)
                                .refreshTokenExpiresAt(
                                                refreshTokenExpiresAt)
                                .isActive(
                                                true)
                                .createdAt(
                                                LocalDateTime.now())
                                .createdBy(
                                                user.getPkUserId())
                                .build();
        }
}

package com.codeaxis.service.auth.factory;

import java.time.LocalDateTime;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.codeaxis.entity.Role;
import com.codeaxis.entity.User;
import com.github.f4b6a3.uuid.UuidCreator;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor

public class UserFactory {

        private final BCryptPasswordEncoder passwordEncoder;

        public User createUser(
                        String username,

                        String email,

                        String rawPassword,

                        Role role) {

                /*
                 * ===========================================================================
                 * CREATE USER ENTITY
                 * ===========================================================================
                 */

                return User.builder()

                                /*
                                 * ===============================================================
                                 * GENERATE USER ID
                                 * ===============================================================
                                 */

                                .pkUserId(
                                                UuidCreator.getTimeOrderedEpoch())

                                .fkRoleId(
                                                role)

                                .username(
                                                username)

                                .email(
                                                email)

                                /*
                                 * ===============================================================
                                 * HASH PASSWORD
                                 * ===============================================================
                                 */

                                .passwordHash(
                                                passwordEncoder.encode(
                                                                rawPassword))

                                .isEmailVerified(
                                                false)

                                .isLocked(
                                                false)

                                .isActive(
                                                true)

                                .isDeleted(
                                                false)

                                .createdAt(
                                                LocalDateTime.now())

                                .updatedAt(
                                                LocalDateTime.now())

                                .build();
        }
}

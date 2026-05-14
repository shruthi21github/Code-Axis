package codeaxis.api.service.auth.factory;

import java.time.LocalDateTime;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.github.f4b6a3.uuid.UuidCreator;

import codeaxis.api.entity.Role;
import codeaxis.api.entity.User;

@Component
public class UserFactory {

        private final BCryptPasswordEncoder passwordEncoder;

        public UserFactory(
                        BCryptPasswordEncoder passwordEncoder) {

                this.passwordEncoder = passwordEncoder;
        }

        public User createUser(
                        String username,

                        String email,

                        String rawPassword,

                        Role role) {

                User user = new User();

                /*
                 * =======================================================================
                 * GENERATE USER ID
                 * =======================================================================
                 * 
                 * Purpose :
                 * Generates time ordered UUID for optimized database indexing.
                 */

                user.setUserId(
                                UuidCreator.getTimeOrderedEpoch());

                user.setRole(role);

                user.setUsername(username);

                user.setEmail(email);

                /*
                 * =======================================================================
                 * HASH PASSWORD
                 * =======================================================================
                 * 
                 * Purpose :
                 * Converts plain password into secure BCrypt hash.
                 * 
                 * Security :
                 * Raw password is never stored in database.
                 */

                user.setPasswordHash(
                                passwordEncoder.encode(
                                                rawPassword));

                user.setIsEmailVerified(false);

                user.setIsLocked(false);

                user.setIsActive(true);

                user.setIsDeleted(false);

                user.setCreatedAt(
                                LocalDateTime.now());

                user.setUpdatedAt(
                                LocalDateTime.now());

                return user;
        }
}
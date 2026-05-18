package codeaxis.api.service.auth.validation;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import codeaxis.api.entity.Role;
import codeaxis.api.exception.ApiException;
import codeaxis.api.repository.RoleRepository;
import codeaxis.api.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor

public class RegisterValidationService {

        private final UserRepository userRepository;

        private final RoleRepository roleRepository;

        public void validateUsername(
                        String username) {

                if (userRepository
                                .existsByUsernameIgnoreCase(
                                                username)) {

                        throw new ApiException(
                                        HttpStatus.CONFLICT,
                                        "Username already exists");
                }
        }

        public void validateEmail(
                        String email) {

                if (userRepository
                                .existsByEmailIgnoreCase(
                                                email)) {

                        throw new ApiException(
                                        HttpStatus.CONFLICT,
                                        "Email address already exists");
                }
        }

        public Role validateAndGetRole(
                        String roleName) {

                /*
                 * =======================================================================
                 * FETCH ROLE
                 * =======================================================================
                 */

                Role role = roleRepository
                                .findByRoleNameIgnoreCase(
                                                roleName)
                                .orElse(null);

                /*
                 * =======================================================================
                 * VALIDATE ROLE EXISTS
                 * =======================================================================
                 */

                if (role == null) {

                        throw new ApiException(
                                        HttpStatus.NOT_FOUND,
                                        "User role not found");
                }

                /*
                 * =======================================================================
                 * VALIDATE ROLE ACTIVE
                 * =======================================================================
                 */

                if (Boolean.FALSE.equals(
                                role.getIsActive())) {

                        throw new ApiException(
                                        HttpStatus.BAD_REQUEST,
                                        "User role inactive");
                }

                /*
                 * =======================================================================
                 * VALIDATE ROLE DELETED
                 * =======================================================================
                 */

                if (Boolean.TRUE.equals(
                                role.getIsDeleted())) {

                        throw new ApiException(
                                        HttpStatus.BAD_REQUEST,
                                        "User role deleted");
                }

                return role;
        }
}

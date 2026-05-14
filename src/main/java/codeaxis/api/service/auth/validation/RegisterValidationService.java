package codeaxis.api.service.auth.validation;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import codeaxis.api.entity.Role;
import codeaxis.api.exception.ApiException;
import codeaxis.api.repository.RoleRepository;
import codeaxis.api.repository.UserRepository;

@Service
public class RegisterValidationService {

        private final UserRepository userRepository;

        private final RoleRepository roleRepository;

        public RegisterValidationService(
                        UserRepository userRepository,

                        RoleRepository roleRepository) {

                this.userRepository = userRepository;

                this.roleRepository = roleRepository;
        }

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
                 * 
                 * Table :
                 * roles
                 * 
                 * Purpose :
                 * Fetches requested role for validation and user assignment.
                 */

                Role role = roleRepository
                                .findByRoleNameIgnoreCase(
                                                roleName)
                                .orElse(null);
                /*
                 * =======================================================================
                 * VALIDATE ROLE EXISTS
                 * =======================================================================
                 * 
                 * Purpose :
                 * Ensures requested role exists.
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
                 * 
                 * Purpose :
                 * Prevents registration using inactive role.
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
                 * 
                 * Purpose :
                 * Prevents registration using deleted role.
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

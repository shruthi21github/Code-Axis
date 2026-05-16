package codeaxis.api.service.auth.validation;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import codeaxis.api.entity.User;
import codeaxis.api.exception.ApiException;

@Service
public class LoginUserValidationService {

    public void validate(User user) {

        if (user == null) {

            throw new ApiException(
                    HttpStatus.UNAUTHORIZED,
                    "Invalid login credentials");
        }

        if (Boolean.FALSE.equals(
                user.getIsActive())) {

            throw new ApiException(
                    HttpStatus.FORBIDDEN,
                    "User account inactive");
        }

        if (Boolean.TRUE.equals(
                user.getIsDeleted())) {

            throw new ApiException(
                    HttpStatus.FORBIDDEN,
                    "User account deleted");
        }

        if (Boolean.TRUE.equals(
                user.getIsLocked())) {

            throw new ApiException(
                    HttpStatus.LOCKED,
                    "User account locked");
        }

        if (Boolean.FALSE.equals(
                user.getIsEmailVerified())) {

            throw new ApiException(
                    HttpStatus.FORBIDDEN,
                    "Email address not verified");
        }

        if (user.getFkRoleId() == null) {

            throw new ApiException(
                    HttpStatus.BAD_REQUEST,
                    "User role assignment invalid");
        }

        if (Boolean.FALSE.equals(
                user.getFkRoleId().getIsActive())) {

            throw new ApiException(
                    HttpStatus.FORBIDDEN,
                    "User role inactive");
        }

        if (Boolean.TRUE.equals(
                user.getFkRoleId().getIsDeleted())) {

            throw new ApiException(
                    HttpStatus.BAD_REQUEST,
                    "User role deleted");
        }
    }
}
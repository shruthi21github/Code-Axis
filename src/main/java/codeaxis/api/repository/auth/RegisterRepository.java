package codeaxis.api.repository.auth;

import java.sql.Timestamp;
import java.sql.Types;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import codeaxis.api.dto.auth.RegisterResponseDto;
import codeaxis.api.exception.ApiException;
import codeaxis.api.utils.UuidUtil;

@Repository
public class RegisterRepository {
    private final SimpleJdbcCall simpleJdbcCall;

    public RegisterRepository(
            DataSource dataSource) {
        this.simpleJdbcCall = new SimpleJdbcCall(dataSource)

                .withProcedureName(
                        "001_sp_auth_register_user")

                .withoutProcedureColumnMetaDataAccess()

                .declareParameters(

                        new SqlParameter(
                                "p_user_id",
                                Types.BINARY),

                        new SqlParameter(
                                "p_email_verification_token_id",
                                Types.BINARY),

                        new SqlParameter(
                                "p_username",
                                Types.VARCHAR),

                        new SqlParameter(
                                "p_email",
                                Types.VARCHAR),

                        new SqlParameter(
                                "p_password_hash",
                                Types.VARCHAR),

                        new SqlParameter(
                                "p_role_name",
                                Types.VARCHAR),

                        new SqlParameter(
                                "p_verification_token_hash",
                                Types.VARCHAR),

                        new SqlParameter(
                                "p_verification_token_expires_at",
                                Types.TIMESTAMP));
    }

    public RegisterResponseDto register(
            UUID userId,

            UUID emailVerificationTokenId,

            String username,

            String email,

            String passwordHash,

            String roleName,

            String verificationTokenHash,

            Timestamp verificationTokenExpiresAt) {
        Map<String, Object> result;

        try {
            result = simpleJdbcCall.execute(
                    Map.of(
                            "p_user_id",
                            UuidUtil.uuidToBytes(userId),

                            "p_email_verification_token_id",
                            UuidUtil.uuidToBytes(
                                    emailVerificationTokenId),

                            "p_username",
                            username,

                            "p_email",
                            email,

                            "p_password_hash",
                            passwordHash,

                            "p_role_name",
                            roleName,

                            "p_verification_token_hash",
                            verificationTokenHash,

                            "p_verification_token_expires_at",
                            verificationTokenExpiresAt));
        } catch (DataAccessException exception) {
            Throwable rootCause = exception.getRootCause();

            if (rootCause != null) {
                throw new ApiException(
                        rootCause.getMessage());
            }

            throw new ApiException(
                    "Database operation failed");
        }

        @SuppressWarnings("unchecked")

        List<Map<String, Object>> rows = (List<Map<String, Object>>) result.get("#result-set-1");

        if (rows == null || rows.isEmpty()) {
            throw new RuntimeException(
                    "Registration failed");
        }

        Map<String, Object> row = rows.get(0);

        RegisterResponseDto response = new RegisterResponseDto();

        response.setUserId(
                (String) row.get("user_id"));

        response.setRoleId(
                (String) row.get("role_id"));

        response.setUsername(
                (String) row.get("username"));

        response.setEmail(
                (String) row.get("email"));

        response.setRoleName(
                (String) row.get("role_name"));

        response.setIsEmailVerified(
                (Boolean) row.get("is_email_verified"));

        response.setIsActive(
                (Boolean) row.get("is_active"));

        response.setCreatedAt(
                ((Timestamp) row.get("created_at"))
                        .toLocalDateTime());

        return response;
    }
}
package codeaxis.api.service.auth;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.UUID;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.github.f4b6a3.uuid.UuidCreator;

import codeaxis.api.dto.auth.RegisterRequestDto;
import codeaxis.api.dto.auth.RegisterResponseDto;
import codeaxis.api.repository.auth.RegisterRepository;
import codeaxis.api.utils.Sha256Util;

@Service
public class RegisterService
{
    private final RegisterRepository registerRepository;

    private final BCryptPasswordEncoder passwordEncoder;

    public RegisterService
    (
        RegisterRepository registerRepository,

        BCryptPasswordEncoder passwordEncoder
    )
    {
        this.registerRepository = registerRepository;

        this.passwordEncoder = passwordEncoder;
    }

    public RegisterResponseDto register
    (
        RegisterRequestDto request
    )
    {
        UUID userId =
            UuidCreator.getTimeOrderedEpoch();

        UUID emailVerificationTokenId =
            UuidCreator.getTimeOrderedEpoch();

        String passwordHash =
            passwordEncoder.encode(
                request.getPassword()
            );

        String rawVerificationToken =
            UuidCreator
                .getTimeOrderedEpoch()
                .toString();

        String verificationTokenHash =
            Sha256Util.hash(
                rawVerificationToken
            );

        Timestamp verificationTokenExpiresAt =
            Timestamp.valueOf(
                LocalDateTime.now().plusHours(24)
            );

        return registerRepository.register(
            userId,

            emailVerificationTokenId,

            request.getUsername(),

            request.getEmail(),

            passwordHash,

            request.getRoleName(),

            verificationTokenHash,

            verificationTokenExpiresAt
        );
    }
}

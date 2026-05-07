package com.codeaxis.controller;

import com.codeaxis.dto.LoginRequest;
import com.codeaxis.dto.LoginResponse;

import com.codeaxis.entity.User;

import com.codeaxis.security.JwtService;

import com.codeaxis.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtService jwtService;

    private BCryptPasswordEncoder encoder =
            new BCryptPasswordEncoder();

    @PostMapping("/login")
    public LoginResponse login(
            @RequestBody LoginRequest request
    ) {

        User user =
                userService.findByUsername(
                        request.getUsername()
                );

        if (user == null) {

            return new LoginResponse(
                    false,
                    "User not found",
                    null,
                    null
            );
        }

        boolean passwordMatch =
                encoder.matches(
                        request.getPassword(),
                        user.getPassword()
                );

        if (!passwordMatch) {

            return new LoginResponse(
                    false,
                    "Invalid password",
                    null,
                    null
            );
        }

        String token =
                jwtService.generateToken(
                        user.getUsername(),
                        user.getRole()
                );

        return new LoginResponse(
                true,
                "Login successful",
                token,
                user.getRole()
        );
    }
}
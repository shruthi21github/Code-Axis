package com.codeaxis.security;

import com.codeaxis.dto.ApiErrorResponseDto;
import com.codeaxis.entity.User;
import com.codeaxis.repository.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Collections;
import java.util.UUID;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

        private final JwtProvider jwtProvider;

        private final UserRepository userRepository;

        private static final ObjectMapper objectMapper = new ObjectMapper();

        public JwtAuthenticationFilter(
                        JwtProvider jwtProvider,
                        UserRepository userRepository) {

                this.jwtProvider = jwtProvider;
                this.userRepository = userRepository;
        }

        @Override
        protected void doFilterInternal(
                        HttpServletRequest request,
                        HttpServletResponse response,
                        FilterChain filterChain)
                        throws ServletException, IOException {

                try {

                        String path = request.getServletPath();

                        /*
                         * ===============================================================
                         * SKIP PUBLIC ROUTES
                         * ===============================================================
                         */

                        if (isPublicRoute(path)) {

                                filterChain.doFilter(request, response);

                                return;
                        }

                        /*
                         * ===============================================================
                         * READ AUTH HEADER
                         * ===============================================================
                         */

                        String authHeader = request.getHeader("Authorization");

                        if (authHeader == null || !authHeader.startsWith("Bearer ")) {

                                writeError(response, "Missing token");

                                return;
                        }

                        /*
                         * ===============================================================
                         * EXTRACT TOKEN
                         * ===============================================================
                         */

                        String token = authHeader.substring(7);

                        /*
                         * ===============================================================
                         * VALIDATE TOKEN
                         * ===============================================================
                         */

                        if (!jwtProvider.isAccessTokenValid(token)) {

                                writeError(response, "Invalid or expired token");

                                return;
                        }

                        /*
                         * ===============================================================
                         * EXTRACT USER ID
                         * ===============================================================
                         */

                        UUID userId = jwtProvider.extractUserId(token);

                        if (userId == null) {

                                writeError(response, "Invalid token payload");

                                return;
                        }

                        /*
                         * ===============================================================
                         * FETCH USER
                         * ===============================================================
                         */

                        User user = userRepository.findById(userId).orElse(null);

                        if (user == null) {

                                writeError(response, "User not found");

                                return;
                        }

                        /*
                         * ===============================================================
                         * SET AUTHENTICATION
                         * ===============================================================
                         */

                        if (SecurityContextHolder.getContext().getAuthentication() == null) {

                                UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                                                user,
                                                null,
                                                Collections.emptyList());

                                authToken.setDetails(
                                                new WebAuthenticationDetailsSource().buildDetails(request));

                                SecurityContextHolder.getContext().setAuthentication(authToken);
                        }

                        filterChain.doFilter(request, response);

                } catch (Exception ex) {

                        ex.printStackTrace();

                        writeError(response, "Authentication failed");
                }
        }

        private boolean isPublicRoute(String path) {

                return path.startsWith("/api/auth/login")
                                || path.startsWith("/api/auth/register")
                                || path.startsWith("/api/auth/refresh-token")
                                || path.startsWith("/api/auth/verify-email")
                                || path.startsWith("/api/auth/forgot-password")
                                || path.startsWith("/api/auth/reset-password")
                                || path.startsWith("/swagger-ui")
                                || path.startsWith("/v3/api-docs");
        }

        private void writeError(
                        HttpServletResponse response,
                        String message)
                        throws IOException {

                response.setStatus(401);

                response.setContentType("application/json");

                ApiErrorResponseDto error = ApiErrorResponseDto.builder()
                                .success(false)
                                .message(message)
                                .error("Unauthorized")
                                .build();

                objectMapper.writeValue(
                                response.getOutputStream(),
                                error);
        }
}

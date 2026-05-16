package codeaxis.api.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.config.Customizer;

import org.springframework.security.config.annotation.web.builders.HttpSecurity;

import org.springframework.security.config.http.SessionCreationPolicy;

import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

        @Bean
        public SecurityFilterChain securityFilterChain(
                        HttpSecurity http)
                        throws Exception {

                http

                                /*
                                 * ===============================================================
                                 * DISABLE CSRF
                                 * ===============================================================
                                 *
                                 * Reason:
                                 * Stateless REST API using token-based authentication.
                                 */

                                .csrf(csrf -> csrf.disable())

                                /*
                                 * ===============================================================
                                 * DISABLE SERVER SESSION
                                 * ===============================================================
                                 *
                                 * Reason:
                                 * JWT/token auth does not require server-side sessions.
                                 */

                                .sessionManagement(session -> session
                                                .sessionCreationPolicy(
                                                                SessionCreationPolicy.STATELESS))

                                /*
                                 * ===============================================================
                                 * ROUTE AUTHORIZATION
                                 * ===============================================================
                                 */

                                .authorizeHttpRequests(auth -> auth

                                                /*
                                                 * =======================================================
                                                 * PUBLIC AUTH ROUTES
                                                 * =======================================================
                                                 */

                                                .requestMatchers(
                                                                "/api/auth/register",
                                                                "/api/auth/login",
                                                                "/api/auth/verify-email",
                                                                "/api/auth/forgot-password",
                                                                "/api/auth/reset-password")
                                                .permitAll()

                                                /*
                                                 * =======================================================
                                                 * ALL OTHER ROUTES REQUIRE AUTHENTICATION
                                                 * =======================================================
                                                 */

                                                .anyRequest()
                                                .authenticated())

                                /*
                                 * ===============================================================
                                 * BASIC AUTH
                                 * ===============================================================
                                 *
                                 * Temporary during development.
                                 * Later replace with JWT authentication filter.
                                 */

                                .httpBasic(
                                                Customizer.withDefaults());

                return http.build();
        }
}

package com.codeaxis.repository;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.codeaxis.entity.User;

public interface UserRepository
                extends JpaRepository<User, UUID> {

        boolean existsByUsernameIgnoreCase(
                        String username);

        boolean existsByEmailIgnoreCase(
                        String email);

        Optional<User> findByEmailIgnoreCase(
                        String email);

        Optional<User> findByEmailIgnoreCaseOrUsernameIgnoreCase(
                        String email,
                        String username);

        Optional<User> findByUsernameIgnoreCase(
                        String username);

        Optional<User> findByEmailIgnoreCaseAndUsernameIgnoreCase(
                        String email,
                        String username);
}

package codeaxis.api.repository;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import codeaxis.api.entity.User;

public interface UserRepository
                extends JpaRepository<User, UUID> {

        boolean existsByUsernameIgnoreCase(
                        String username);

        boolean existsByEmailIgnoreCase(
                        String email);

        Optional<User> findByEmailIgnoreCase(
                        String email);
}

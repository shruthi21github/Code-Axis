package codeaxis.api.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import codeaxis.api.entity.Role;

public interface RoleRepository
                extends JpaRepository<Role, java.util.UUID> {

        Optional<Role> findByRoleNameIgnoreCase(
                        String roleName);
}

package com.codeaxis.repository;

import com.codeaxis.entity.RolePermission;
import com.codeaxis.entity.Role;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface RolePermissionRepository
        extends JpaRepository<RolePermission, UUID> {

    List<RolePermission> findByRole(Role role);
}
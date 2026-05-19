package com.codeaxis.rolebasedaccess.repository;

import com.codeaxis.rolebasedaccess.entity.Role;
import com.codeaxis.rolebasedaccess.entity.RolePermission;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface RolePermissionRepository
        extends JpaRepository<RolePermission, UUID> {

    List<RolePermission> findByRole(Role role);
}
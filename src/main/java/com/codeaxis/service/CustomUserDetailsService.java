package com.codeaxis.service;

import com.codeaxis.entity.Permission;
import com.codeaxis.entity.RolePermission;
import com.codeaxis.entity.User;

import com.codeaxis.repository.RolePermissionRepository;
import com.codeaxis.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomUserDetailsService
        implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RolePermissionRepository rolePermissionRepository;

    @Transactional
    @Override
    public UserDetails loadUserByUsername(
            String username)
            throws UsernameNotFoundException {

        User user = userRepository
                .findByUsernameIgnoreCase(username)
                .orElseThrow(() ->
                        new UsernameNotFoundException(
                                "User not found"));

        List<RolePermission> rolePermissions =
                rolePermissionRepository.findByRole(
                        user.getFkRoleId());

        List<GrantedAuthority> authorities =
                new ArrayList<>();

        authorities.add(
                new SimpleGrantedAuthority(
                        "ROLE_" +
                                user.getFkRoleId()
                                        .getRoleName()
                )
        );

        for (RolePermission rolePermission
                : rolePermissions) {

            Permission permission =
                    rolePermission.getPermission();

            authorities.add(
                    new SimpleGrantedAuthority(
                            permission.getPermissionName()
                    )
            );
        }

        return new org.springframework.security.core.userdetails.User(

                user.getUsername(),

                user.getPasswordHash(),

                user.getIsActive(),

                true,

                true,

                !user.getIsLocked(),

                authorities
        );
    }
}
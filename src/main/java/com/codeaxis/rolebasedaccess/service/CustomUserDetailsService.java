package com.codeaxis.rolebasedaccess.service;

import com.codeaxis.rolebasedaccess.entity.Permission;
import com.codeaxis.rolebasedaccess.entity.RolePermission;
import com.codeaxis.rolebasedaccess.entity.User;
import com.codeaxis.rolebasedaccess.repository.RolePermissionRepository;
import com.codeaxis.rolebasedaccess.repository.UserRepository;

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
                .findByUsername(username)
                .orElseThrow(() ->
                        new UsernameNotFoundException(
                                "User not found"));

        List<RolePermission> rolePermissions =
                rolePermissionRepository.findByRole(
                        user.getRole());

        List<GrantedAuthority> authorities =
                new ArrayList<>();

        authorities.add(
                new SimpleGrantedAuthority(
                        "ROLE_" +
                                user.getRole()
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
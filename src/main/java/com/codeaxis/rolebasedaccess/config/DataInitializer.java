package com.codeaxis.rolebasedaccess.config;


import com.codeaxis.rolebasedaccess.entity.User;
import com.codeaxis.rolebasedaccess.enums.Role;
import com.codeaxis.rolebasedaccess.repository.UserRepository;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Set;

@Configuration
public class DataInitializer {

    @Bean
    public CommandLineRunner setupData(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        return args -> {
            // Create Admin
            if (userRepository.findByUsername("admin").isEmpty()) {
                User admin = new User();
                admin.setUsername("admin");
                admin.setPassword(passwordEncoder.encode("admin123"));
                admin.setRoles(Set.of(Role.ADMIN));
                userRepository.save(admin);
            }

            // Create Employee
            if (userRepository.findByUsername("employee").isEmpty()) {
                User employee = new User();
                employee.setUsername("employee");
                employee.setPassword(passwordEncoder.encode("emp123"));
                employee.setRoles(Set.of(Role.EMPLOYEE));
                userRepository.save(employee);
            }

            // Create Client
            if (userRepository.findByUsername("client").isEmpty()) {
                User client = new User();
                client.setUsername("client");
                client.setPassword(passwordEncoder.encode("client123"));
                client.setRoles(Set.of(Role.CLIENT));
                userRepository.save(client);
            }

            System.out.println("--- Test Users Created ---");
            System.out.println("Admin: admin / admin123");
            System.out.println("Employee: employee / emp123");
            System.out.println("Client: client / client123");
        };
    }
}
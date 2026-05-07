package com.codeaxis.repository;

import com.codeaxis.entity.User;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Repository;

import java.io.InputStream;
import java.util.List;

@Repository
public class UserRepository {

    public List<User> getUsers() {

        try {

            ObjectMapper mapper =
                    new ObjectMapper();

            InputStream inputStream =
                    new ClassPathResource(
                            "users.json"
                    ).getInputStream();

            return mapper.readValue(
                    inputStream,
                    new TypeReference<List<User>>() {}
            );

        } catch (Exception e) {

            throw new RuntimeException(e);
        }
    }
    public User findByUsername(
            String username
    ) {

        return getUsers()
                .stream()
                .filter(user ->
                        user.getUsername()
                                .equals(username)
                )
                .findFirst()
                .orElse(null);
    }
}
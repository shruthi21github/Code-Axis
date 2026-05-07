package com.codeaxis.service;

import com.codeaxis.entity.User;
import com.codeaxis.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User findByUsername(
            String username
    ) {

        return userRepository
                .findByUsername(username);
    }
}
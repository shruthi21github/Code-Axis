package com.codeaxis.repository;

import com.codeaxis.entity.RefreshToken;
import org.springframework.data.jpa.repository.JpaRepository;
import com.codeaxis.entity.User;

import java.util.Optional;

public interface RefreshTokenRepository extends JpaRepository<RefreshToken, Long>{
    Optional<RefreshToken> findByToken(String token);
    
    Optional<RefreshToken> findByUser(User user);
}

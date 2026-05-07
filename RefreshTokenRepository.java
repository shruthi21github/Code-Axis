package com.codeaxis.repository;

import java.util.Optional;

public interface RefreshTokenRepository extends JpaRepository<RefreshToken, Long>{
    Optional<RefershToken> findByToken(String token);
    Optional<RefreshToken> findByUser(String user);
}

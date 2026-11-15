package com.backend.charity.repository;

import com.backend.charity.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String email);

    Optional<User> findByToken(String token); // Matches the corrected field name

    boolean existsByEmail(String email);

    Optional<User> findById(Long id);

}

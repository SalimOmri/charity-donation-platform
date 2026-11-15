package com.backend.charity.repository;

import com.backend.charity.model.Association;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AssociationRepository extends JpaRepository<Association, Long> {

    Optional<Association> findByEmail(String email);

    Optional<Association> findByToken(String token); // Matches the corrected field name

    boolean existsByEmail(String email);

    Optional<Association> findById(Long id);

}

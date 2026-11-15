package com.backend.charity.repository;

import com.backend.charity.model.Donation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository

public interface DonationRepository extends JpaRepository<Donation, Long> {
    List<Donation> findByClientId(Long userId);
    List<Donation> findByEventId(Long eventId);
}

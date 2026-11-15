package com.backend.charity.controller;

import com.backend.charity.dto.Request.DonationRequest;
import com.backend.charity.model.Donation;
import com.backend.charity.repository.DonationRepository;
import com.backend.charity.repository.EventRepository;
import com.backend.charity.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/donations")
@RequiredArgsConstructor
public class DonationController {

    private final DonationRepository donationRepository;
    private final UserRepository userRepository;
    private final EventRepository eventRepository;
    @GetMapping("/user/{userId}")
    public ResponseEntity<?> getUserDonations(@PathVariable Long userId) {
        var user = userRepository.findById(userId);

        if (user.isEmpty()) {
            return ResponseEntity.badRequest().body("User not found");
        }

        List<Donation> donations = donationRepository.findByClientId(userId);
        return ResponseEntity.ok(donations);
    }

    @PostMapping("/{userId}/{eventId}")
    public ResponseEntity<?> donate(
            @PathVariable Long userId,
            @PathVariable Long eventId,
            @RequestBody DonationRequest request
    ) {
        var user = userRepository.findById(userId);
        var event = eventRepository.findById(eventId);
        System.out.println("id user: "+userId+"id event : "+eventId);
        if (user.isEmpty() || event.isEmpty()) {
            return ResponseEntity.badRequest().body("User or Event not found");
        }

        Donation donation = Donation.builder()
                .client(user.get())
                .event(event.get())
                .montant(request.getMontant())
                .items(request.getItems())
                .build();

        donationRepository.save(donation);
        return ResponseEntity.ok("Donation recorded ✅");
    }

}

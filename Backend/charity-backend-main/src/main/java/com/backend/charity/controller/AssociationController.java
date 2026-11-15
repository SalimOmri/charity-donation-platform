package com.backend.charity.controller;

import com.backend.charity.model.Association;
import com.backend.charity.repository.AssociationRepository;
import com.backend.charity.service.AssociationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("user/associations")
@RequiredArgsConstructor
public class AssociationController {
    private final AssociationService associationService;
    private final AssociationRepository associationRepository;

    @GetMapping
    public List<Association> getAll() {
        return associationService.getAllAssociations();
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> update(@PathVariable Long id, @RequestParam String statue) {
        boolean updated = associationService.updateAssociationStatue(id, statue);
        if (updated) {
            return ResponseEntity.ok("Association statue updated successfully.");
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    @PutMapping("/update/{id}")
    public ResponseEntity<?> updateAssociation(@PathVariable Long id, @RequestBody Map<String, Object> updates) {
        Optional<Association> optional = associationRepository.findById(id);
        if (optional.isEmpty()) {
            return ResponseEntity.status(404).body("Association not found ❌");
        }

        Association assoc = optional.get();

        updates.forEach((key, value) -> {
            switch (key) {
                case "name" -> assoc.setName((String) value);
                case "email" -> assoc.setEmail((String) value);
                case "phoneNumber" -> assoc.setPhoneNumber((String) value);
                default -> System.out.println("❓ Unknown field: " + key);
            }
        });

        associationRepository.save(assoc);
        return ResponseEntity.ok(assoc);
    }


    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        associationService.deleteAssociation(id);
    }
}


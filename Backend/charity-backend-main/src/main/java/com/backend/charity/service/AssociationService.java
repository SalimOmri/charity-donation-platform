package com.backend.charity.service;

import com.backend.charity.model.Association;
import com.backend.charity.repository.AssociationRepository;
import com.backend.charity.repository.EventRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AssociationService {
    private final AssociationRepository associationRepository;
    private final EventRepository eventRepository;
    public List<Association> getAllAssociations() {
        return associationRepository.findAll();
    }

    @Transactional
    public void deleteAssociation(Long id) {
        eventRepository.deleteAllByAssociationId(id);
        associationRepository.deleteById(id);
    }

    public boolean updateAssociationStatue(Long associationId, String statue) {
        Optional<Association> associationOptional = associationRepository.findById(associationId);
        if (associationOptional.isPresent()) {
            Association association = associationOptional.get();
            association.setStatue(statue);
            associationRepository.save(association);
            return true;
        }
        return false;
    }
}

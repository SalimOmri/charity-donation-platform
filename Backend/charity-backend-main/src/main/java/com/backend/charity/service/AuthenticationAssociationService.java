package com.backend.charity.service;

import com.backend.charity.dto.Request.AuthenticationAccosiationRequest;
import com.backend.charity.dto.Request.RegisterAssociationRequest;
import com.backend.charity.model.Association;
import com.backend.charity.repository.AssociationRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.mail.MessagingException;
import java.util.Optional;
import java.util.UUID;
@Service
public class AuthenticationAssociationService {

    @Autowired
    private AssociationRepository associationRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    private static final Logger logger = LoggerFactory.getLogger(AuthenticationAssociationService.class);

    // Register a new association
    public String registerAssociation(RegisterAssociationRequest request) throws MessagingException {
        if (associationRepository.existsByEmail(request.getEmail())) {
            logger.error("Association with this email already exists: {}", request.getEmail());
            throw new RuntimeException("Association with this email already exists.");
        }

        String verificationToken = UUID.randomUUID().toString();

        Association association = Association.builder()
                .name(request.getName())
                .phoneNumber(request.getPhoneNumber())
                .email(request.getEmail())
                .statue(request.getStatue())
                .token(verificationToken)
                .password(passwordEncoder.encode(request.getPassword()))
                .build();

        associationRepository.save(association);
        logger.info("Association saved successfully!");
        return association.getToken();
    }

    // Verify the token for association
    @Transactional
    public boolean verifyTokenAssociation(String token) {
        Optional<Association> associationOpt = associationRepository.findByToken(token);

        if (associationOpt.isPresent()) {
            Association association = associationOpt.get();
            associationRepository.save(association);
            return true;
        }

        return false;
    }


    // Authenticate an association
    public Association authenticateAssociation(AuthenticationAccosiationRequest request) {
        logger.info("Authenticating association with email: {}", request.getEmail());

        Association association = associationRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> {
                    logger.error("Invalid email: {}", request.getEmail());
                    throw new RuntimeException("Invalid email.");
                });

        if (!passwordEncoder.matches(request.getPassword(), association.getPassword())) {
            logger.error("Invalid password for email: {}", request.getEmail());
            throw new RuntimeException("Invalid password.");
        }

        return association;
    }
}

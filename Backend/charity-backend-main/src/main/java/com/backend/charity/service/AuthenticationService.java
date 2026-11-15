package com.backend.charity.service;

import com.backend.charity.dto.Request.AuthenticationRequest;
import com.backend.charity.dto.Request.RegisterRequest;
import com.backend.charity.model.Role;
import com.backend.charity.model.User;
import com.backend.charity.repository.UserRepository;
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
public class AuthenticationService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    private static final Logger logger = LoggerFactory.getLogger(AuthenticationService.class);

    // تسجيل مستخدم جديد
    public String registerUser(RegisterRequest request) throws MessagingException {
        if (userRepository.existsByEmail(request.getEmail())) {
            logger.error("User with this email already exists: {}", request.getEmail());
            throw new RuntimeException("User with this email already exists.");
        }

        String verificationToken = UUID.randomUUID().toString();
        var user = User.builder()
                .firstname(request.getFirstname())
                .lastname(request.getLastname())
                .phoneNumber(request.getPhoneNumber())
                .email(request.getEmail())
                .status(false)  // حالة المستخدم يجب أن تكون false عند التسجيل
                .token(verificationToken)
                .password(passwordEncoder.encode(request.getPassword()))
                .role(Role.USER)
                .build();
        userRepository.save(user);
        logger.info("User saved successfully!");
        return user.getToken();
    }

    // التحقق من التوكن
    @Transactional
    public boolean verifyToken(String token) {
        Optional<User> userOpt = userRepository.findByToken(token);

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setStatus(true); // تحديث حالة المستخدم إلى true
            userRepository.save(user);
            return true;
        }

        return false;
    }

    // التحقق من حالة البريد الإلكتروني
    public boolean isEmailVerified(String email) {
        return userRepository.findByEmail(email).map(User::getStatus).orElse(false);
    }

    public User authenticate(AuthenticationRequest request) {
        System.out.println(request.getPassword());
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> {
                    logger.error("Invalid email: {}", request.getEmail());
                    throw new RuntimeException("Invalid email.");
                });

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            logger.error("Invalid password for email: {}", request.getEmail());
            throw new RuntimeException("Invalid password.");
        }
        return user;
    }


}

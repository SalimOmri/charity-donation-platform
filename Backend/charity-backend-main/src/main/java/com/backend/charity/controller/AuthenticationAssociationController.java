package com.backend.charity.controller;

import com.backend.charity.dto.Request.AuthenticationAccosiationRequest;
import com.backend.charity.dto.Request.RegisterAssociationRequest;
import com.backend.charity.model.Association;
import com.backend.charity.service.AuthenticationAssociationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.mail.MessagingException;
import java.util.HashMap;
import java.util.Map;
@RestController
@RequestMapping("/auth/association")
public class AuthenticationAssociationController {

    private final AuthenticationAssociationService associationService;
    private static final Logger logger = LoggerFactory.getLogger(AuthenticationController.class);

    public AuthenticationAssociationController(AuthenticationAssociationService associationService) {
        this.associationService = associationService;
    }

    @PostMapping("/sign-up")
    public ResponseEntity<Map<String, String>> registerUser(@RequestBody RegisterAssociationRequest request) {
        Map<String, String> response = new HashMap<>();
        try {
            // استدعاء دالة التسجيل من الخدمة و الحصول على الـ token
            String token = associationService.registerAssociation(request);

            // إضافة الـ token إلى الاستجابة
            response.put("token", token);

            // إرجاع الـ Response مع الـ token
            return ResponseEntity.ok(response);
        } catch (MessagingException e) {
            logger.error("❌ Email sending failed: {}", e.getMessage());
            response.put("error", "Failed to send verification email. Please try again later.");
            return ResponseEntity.status(500).body(response); // 500 Internal Server Error
        } catch (RuntimeException e) {
            logger.error("❌ Registration failed: {}", e.getMessage());
            response.put("error", e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }



    @PostMapping("/sign-in")
    public ResponseEntity<Association> authenticate(@RequestBody AuthenticationAccosiationRequest request) {
        logger.info("🔍 Authentication request received for email: {}", request.getEmail());
        try {
             Association association = associationService.authenticateAssociation(request); // نرجع الآن كائن User
            logger.info("✅ Token generated successfully for email: {}", request.getEmail());
            logger.info("✅ Token generated successfully for id: {}", association.getId());
            logger.info("User details: {}", association.toString());  // يمكنك طباعة بيانات المستخدم إذا أردت
            return ResponseEntity.ok(association);  // نرجع الـ User بدلاً من Map
        } catch (RuntimeException e) {
            logger.error("❌ Authentication failed for email {}: {}", request.getEmail(), e.getMessage());
            return ResponseEntity.status(401).body(null); // 401 Unauthorized
        }
    }
}

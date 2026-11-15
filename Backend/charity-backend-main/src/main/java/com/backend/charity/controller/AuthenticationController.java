package com.backend.charity.controller;

import com.backend.charity.dto.Request.AuthenticationRequest;
import com.backend.charity.dto.Request.RegisterRequest;
import com.backend.charity.model.User;
import com.backend.charity.service.AuthenticationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.mail.MessagingException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/auth")
public class AuthenticationController {

    private final AuthenticationService authenticationService;
    private static final Logger logger = LoggerFactory.getLogger(AuthenticationController.class);

    public AuthenticationController(AuthenticationService authenticationService) {
        this.authenticationService = authenticationService;
    }

    @PostMapping("/sign-up")
    public ResponseEntity<Map<String, String>> registerUser(@RequestBody RegisterRequest request) {
        Map<String, String> response = new HashMap<>();
        try {
            // استدعاء دالة التسجيل من الخدمة و الحصول على الـ token
            String token = authenticationService.registerUser(request);

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
    public ResponseEntity<User> authenticate(@RequestBody AuthenticationRequest request) {
        logger.info("🔍 Authentication request received for email: {}", request.getEmail());
        try {
            User user = authenticationService.authenticate(request); // نرجع الآن كائن User
            logger.info("✅ Token generated successfully for email: {}", request.getEmail());
            logger.info("✅ Token generated successfully for id: {}", user.getId());
            logger.info("User details: {}", user.toString());  // يمكنك طباعة بيانات المستخدم إذا أردت
            return ResponseEntity.ok(user);  // نرجع الـ User بدلاً من Map
        } catch (RuntimeException e) {
            logger.error("❌ Authentication failed for email {}: {}", request.getEmail(), e.getMessage());
            return ResponseEntity.status(401).body(null); // 401 Unauthorized
        }
    }


    @GetMapping("/verify")
    public ResponseEntity<String> verifyUser(@RequestParam("token") String token) {
        boolean isTokenValid = authenticationService.verifyToken(token);

        if (isTokenValid) {
            return ResponseEntity.ok("Account successfully verified.");
        } else {
            return ResponseEntity.badRequest().body("Invalid or expired token.");
        }
    }


    @GetMapping("/check-verification")
    public ResponseEntity<Map<String, Boolean>> checkEmailVerification(@RequestParam("email") String email) {
        boolean isVerified = authenticationService.isEmailVerified(email);
        return ResponseEntity.ok(Map.of("verified", isVerified));
    }

}
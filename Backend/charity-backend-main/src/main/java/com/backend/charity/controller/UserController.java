package com.backend.charity.controller;


import com.backend.charity.model.User;
import com.backend.charity.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import java.util.List;
import java.util.Map;
import java.util.Optional;
@RequestMapping("/user")
@RestController
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/{id}")
    public  ResponseEntity<User> getUserDetailsById(@PathVariable Long id) {
        Optional<User> user = userService.findByUserId(id);
        return user.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }
    @GetMapping("/all")
    public ResponseEntity<List<User>> getAllUsers() {
        List<User> users = userService.getAllUser();
        return ResponseEntity.ok(users);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteUser(@PathVariable Long id) {
        boolean deleted = userService.deleteUser(id);
        if (deleted) {
            return ResponseEntity.ok("User deleted successfully");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
        }
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<?> updateUser(@PathVariable Long id, @RequestBody Map<String, Object> updates) {
        Optional<User> userOptional = userService.findByUserId(id);
        System.out.println("🔹 Update request received: " + updates);
        if (userOptional.isEmpty()) {
            return ResponseEntity.status(404).body("User not found ❌");
        }

        User user = userOptional.get();

        // معالجة الحقول المرسلة في الـ request
        updates.forEach((key, value) -> {
            switch (key) {
                case "firstname" -> {
                    if (value instanceof String) {
                        user.setFirstname((String) value);
                    } else {
                        System.out.println("⚠️ Invalid value for firstname");
                    }
                }
                case "lastname" -> {
                    if (value instanceof String) {
                        user.setLastname((String) value);
                    } else {
                        System.out.println("⚠️ Invalid value for lastname");
                    }
                }
                case "email" -> {
                    if (value instanceof String && isValidEmail((String) value)) {
                        user.setEmail((String) value);
                    } else {
                        System.out.println("⚠️ Invalid email format");
                    }
                }
                case "phoneNumber" -> {
                    if (value instanceof String) {
                        user.setPhoneNumber((String) value);
                    } else {
                        System.out.println("⚠️ Invalid value for phoneNumber");
                    }
                }
                case "gender" -> {
                    if (value instanceof String) {
                        user.setGender((String) value);
                    } else {
                        System.out.println("⚠️ Invalid value for gender");
                    }
                }
                case "dateOfBirth" -> {
                    if (value instanceof String) {
                        user.setDateOfBirth((String) value);
                    } else {
                        System.out.println("⚠️ Invalid value for dateOfBirth");
                    }
                }
                default -> {
                    System.out.println("⚠️ Unknown field: " + key);
                }
            }
        }
        );

        userService.saveUser(user);
        return ResponseEntity.ok(user);
    }

    // دالة للتحقق من صحة البريد الإلكتروني
    private boolean isValidEmail(String email) {
        // يمكن تعديلها حسب الاحتياج
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email.matches(emailRegex);
    }



}

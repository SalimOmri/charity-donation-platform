package com.backend.charity.service;


import com.backend.charity.model.User;
import com.backend.charity.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;
    public List<User> getAllUser() {
        return userRepository.findAll();
    }
    @Transactional
    public boolean deleteUser(Long id) {
        Optional<User> user = userRepository.findById(id);
        if (user.isPresent()) {
            userRepository.delete(user.get());
            return true;
        }
        return false;
    }
    public Optional<User> findByUserId(Long id) {
        return userRepository.findById(id);
    }
    public void saveUser(User user) {
        userRepository.save(user);
    }
}
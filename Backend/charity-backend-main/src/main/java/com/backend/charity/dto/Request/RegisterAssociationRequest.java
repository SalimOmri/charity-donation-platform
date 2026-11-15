package com.backend.charity.dto.Request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegisterAssociationRequest {
    @NotBlank(message = "name cannot be blank")
    @Size(min = 2, max = 50, message = "First name must be between 2 and 50 characters")
    private String name;
    @NotBlank(message = "Phone Number cannot be blank")
    @Size(min = 2, max = 50, message = "Phone Number must be between 2 and 50 characters")
    private String phoneNumber;
    @NotBlank(message = "Email cannot be blank")
    @Email(message = "Invalid email address")
    private String email;
    @NotBlank(message = "Password cannot be blank")
    @Size(min = 8, max = 100, message = "Password must be between 8 and 100 characters")
    private String password;
    @NotBlank(message = "statue cannot be blank")
    @Size(min = 8, max = 100, message = "statue must be between 8 and 100 characters")
    private String statue;
}

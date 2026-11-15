package com.backend.charity.dto.Request;

import lombok.Data;

@Data
public class VerifyRequest {
    private String document;
    private String signature;
    private String userType;
}

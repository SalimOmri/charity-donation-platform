package com.backend.charity.dto.Request;

import lombok.Data;

@Data
public class DonationRequest {
    private String montant;
    private String items;
}

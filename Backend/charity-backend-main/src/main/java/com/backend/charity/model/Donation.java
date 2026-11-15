package com.backend.charity.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;
import javax.persistence.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Donation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String montant;
    private String items;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User client;
    @ManyToOne
    @JoinColumn(name = "event_id")
    @JsonIgnoreProperties("donations")
    private Event event;
}

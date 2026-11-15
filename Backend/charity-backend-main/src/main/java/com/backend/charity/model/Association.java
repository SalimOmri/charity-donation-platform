package com.backend.charity.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;

@Getter
@Setter
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "accociations")
public class Association {
    @Id
    @GeneratedValue
    private Long id;
    private String name;
    private String statue;
    private String phoneNumber;
    @Column(name = "token") // Optional: Explicitly specify the column name if needed
    private String token;
    @Column
    private String email;
    @JsonIgnore
    private String password;
}

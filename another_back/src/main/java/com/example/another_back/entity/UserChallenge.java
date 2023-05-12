package com.example.another_back.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserChallenge {

    @Column(name = "user_challenge_id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String status;

    private Integer userChallengeValue;

    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    private Challenge challenge;

    public UserChallenge(User user, Challenge challenge) {
        this.status = "SILVER";
        this.user = user;
        this.challenge = challenge;
        this.userChallengeValue = 0;
    }
}

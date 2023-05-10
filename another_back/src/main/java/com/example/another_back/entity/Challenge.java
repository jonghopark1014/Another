package com.example.another_back.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Challenge {

    @Column(name = "challenge_id")
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String challengeName;
    private Integer challengeCategory;
    private Integer challengeTarget;
    private String challengeSilver;
    private String challengeGold;

    @OneToMany(mappedBy = "challenge")
    private List<UserChallenge> userChallengeList = new ArrayList<>();
}

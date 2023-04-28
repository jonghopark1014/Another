package com.example.another_back.entity;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class User {

    @Column(name = "user_id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private Integer height;
    private Integer weight;
    private String sex;
    private Integer exp;
    private Integer level;
    private String nickname;
    private String profilePic;

    @OneToMany(mappedBy = "user")
    private List<UserChallenge> userChallengeList = new ArrayList<>();

    @Builder
    public User(Long id, String username, Integer height, Integer weight, String sex, Integer exp, Integer level, String nickname, String profilePic, List<UserChallenge> userChallengeList) {
        this.nickname = nickname;
        this.id = id;
        this.username = username;
        this.height = height;
        this.weight = weight;
        this.sex = sex;
        this.exp = exp;
        this.level = level;
        this.profilePic = profilePic;
        this.userChallengeList = userChallengeList;
    }
}

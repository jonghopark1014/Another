package com.example.another_back.entity;

import com.example.another_back.dto.UserUpdateForm;
import com.example.another_back.entity.enums.Role;
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
    private String password;
    private Integer height;
    private Integer weight;
    private String sex;
    private Integer exp;
    private Integer level;
    private String nickname;

    @Enumerated(value = EnumType.STRING)
    private Role role;
    private String profilePic;

    @OneToMany(mappedBy = "user")
    private List<UserChallenge> userChallengeList = new ArrayList<>();

    @OneToMany(mappedBy = "user")
    private List<Running> runningList = new ArrayList<>();

    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }

    public void updateUser(UserUpdateForm userUpdateForm) {
        this.nickname = userUpdateForm.getNickname();
        this.weight = userUpdateForm.getWeight();
        this.height = userUpdateForm.getHeight();
    }

    @Builder
    public User(Long id, String username, String password, Integer height, Integer weight, String sex, Integer exp, Integer level, String nickname, Role role, String profilePic, List<UserChallenge> userChallengeList) {
        this.nickname = nickname;
        this.id = id;
        this.username = username;
        this.password = password;
        this.height = height;
        this.weight = weight;
        this.sex = sex;
        this.exp = exp;
        this.level = level;
        this.role = role;
        this.profilePic = profilePic;
        this.userChallengeList = userChallengeList;
    }
}

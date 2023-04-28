package com.example.another_back.dto;

import com.example.another_back.entity.enums.Role;
import lombok.Builder;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;

@Data
public class UserJoinDto {

    private String username;
    private String password;
    private String nickname;
    private Integer height;
    private Integer weight;
    private String sex;
    private Integer exp;
    private Integer level;
    private MultipartFile profilePic;
    @Enumerated(EnumType.STRING)
    private Role role;

    @Builder
    public UserJoinDto(String username, String password, String nickname, Integer height, Integer weight, String sex, Integer exp, Integer level, MultipartFile profilePic, Role role) {
        this.username = username;
        this.password = password;
        this.nickname = nickname;
        this.height = height;
        this.weight = weight;
        this.sex = sex;
        this.exp = exp;
        this.level = level;
        this.profilePic = profilePic;
        this.role = role;
    }
}

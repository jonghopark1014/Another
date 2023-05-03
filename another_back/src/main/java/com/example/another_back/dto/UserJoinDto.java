package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

@Data
public class UserJoinDto {

    private String username;
    private String password;
    private String nickname;
    private Integer height;
    private Integer weight;
    private String sex;

//    @Builder
//    public UserJoinDto(String username, String password, String nickname, Integer height, Integer weight, String sex) {
//        this.username = username;
//        this.password = password;
//        this.nickname = nickname;
//        this.height = height;
//        this.weight = weight;
//        this.sex = sex;
//    }
}

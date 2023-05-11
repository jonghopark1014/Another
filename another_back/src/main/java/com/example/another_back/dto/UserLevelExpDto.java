package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

@Data
public class UserLevelExpDto {
    private Integer level;
    private Integer Exp;
    private String nickname;
    private String profilePic;

    @Builder
    public UserLevelExpDto(Integer level, Integer exp, String nickname, String profilePic) {
        this.level = level;
        this.Exp = exp;
        this.nickname = nickname;
        this.profilePic = profilePic;
    }
}

package com.example.another_back.dto;

import com.example.another_back.entity.User;
import lombok.Getter;

@Getter
public class LoginResponseDto {
    private Long userId;
    private String nickname;
    private Integer weight;
    private Integer height;

    public LoginResponseDto(User user) {
        this.userId = user.getId();
        this.nickname = user.getNickname();
        this.weight = user.getWeight();
        this.height = user.getHeight();
    }
}

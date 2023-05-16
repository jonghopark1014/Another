package com.example.another_back.dto;

import lombok.Getter;

@Getter
public class UserStartDto {
    private Long userId;
    private String nickname;

    public UserStartDto(Long userId, String nickname) {
        this.userId = userId;
        this.nickname = nickname;
    }
}

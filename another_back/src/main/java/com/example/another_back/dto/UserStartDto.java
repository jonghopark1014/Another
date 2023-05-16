package com.example.another_back.dto;

import lombok.Getter;

@Getter
public class UserStartDto {
    private Object userId;
    private Object nickname;
    private Object weight;
    private Object height;

    public UserStartDto(Object userId, Object nickname, Object weight, Object height) {
        this.userId = userId;
        this.nickname = nickname;
        this.weight = weight;
        this.height = height;
    }
}

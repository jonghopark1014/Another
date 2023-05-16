package com.example.another_back.dto;

import lombok.Getter;

@Getter
public class UserStartDto {
    private Object userId;
    private Object nickname;

    public UserStartDto(Object userId, Object nickname) {
        this.userId = userId;
        this.nickname = nickname;
    }
}

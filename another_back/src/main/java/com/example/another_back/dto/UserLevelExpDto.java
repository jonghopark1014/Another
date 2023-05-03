package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

@Data
public class UserLevelExpDto {
    private Integer level;
    private Integer Exp;

    @Builder
    public UserLevelExpDto(Integer level, Integer exp) {
        this.level = level;
        Exp = exp;
    }
}

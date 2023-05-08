package com.example.another_back.dto;

import lombok.Getter;

@Getter
public class SearchRequestDto {
    private Long userId;
    private Float runningDistance;
    private Integer runningTime;
}

package com.example.another_back.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
public class MonthDistanceResponseDto {
    private Float thisMonthDistance;

    private Float lastMonthDistance;

    @Builder
    public MonthDistanceResponseDto(Float thisMonthDistance, Float lastMonthDistance) {
        this.thisMonthDistance = thisMonthDistance;
        this.lastMonthDistance = lastMonthDistance;
    }
}

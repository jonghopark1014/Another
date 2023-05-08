package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RunningHistoryDto {
    private Long runningTime;
    private Double runningDistance;
    private Long dayOfRunning;
    private Long kcal;

    public RunningHistoryDto(Long runningTime, Double runningDistance, Long dayOfRunning, Long kcal) {
        this.runningTime = runningTime;
        this.runningDistance = runningDistance;
        this.dayOfRunning = dayOfRunning;
        this.kcal = kcal;
    }
}

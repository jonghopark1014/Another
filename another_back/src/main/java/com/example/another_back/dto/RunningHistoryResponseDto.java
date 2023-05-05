package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.domain.Page;

@Data
public class RunningHistoryResponseDto {
    private String runningTime;
    private Double runningDistance;
    private Long dayOfRunning;
    private Long walkCount;
    private Long kcal;
    private Page<RunningEachHistoryDto> runningData;

    @Builder
    public RunningHistoryResponseDto(String runningTime, Double runningDistance, Long dayOfRunning, Long walkCount, Long kcal, Page<RunningEachHistoryDto> runningData) {
        this.runningTime = runningTime;
        this.runningDistance = runningDistance;
        this.dayOfRunning = dayOfRunning;
        this.walkCount = walkCount;
        this.kcal = kcal;
        this.runningData = runningData;
    }
}

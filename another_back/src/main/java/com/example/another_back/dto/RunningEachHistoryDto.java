package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

@Data
public class RunningEachHistoryDto {
    private Integer runningTime;
    private Float runningDistance;
    private String createDate;
    private Integer walkCount;
    private Integer kcal;

    @Builder
    public RunningEachHistoryDto(Integer runningTime, Float runningDistance, java.util.Date createDate, Integer walkCount, Integer kcal) {
        this.runningTime = runningTime;
        this.runningDistance = runningDistance;
        this.createDate = new java.sql.Date(createDate.getTime()).toString();
        this.walkCount = walkCount;
        this.kcal = kcal;
    }
}

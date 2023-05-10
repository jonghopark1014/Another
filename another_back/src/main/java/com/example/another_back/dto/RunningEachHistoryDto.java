package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

@Data
public class RunningEachHistoryDto {
    private String runningTime;
    private Float runningDistance;
    private String createDate;
    private Integer userCalories;

    @Builder
    public RunningEachHistoryDto(Integer runningTime, Float runningDistance, java.util.Date createDate, Integer userCalories) {
        long hour = 0;
        long minute = 0;
        long second = 0;

        Long time = runningTime.longValue();
        hour = time / 3600;
        time %= 3600;
        minute = time / 60;
        second = time % 60;

        this.runningTime = hour + ":" + minute + ":" + second;
        this.runningDistance = runningDistance;
        this.createDate = new java.sql.Date(createDate.getTime()).toString();
        this.userCalories = userCalories;
    }
}

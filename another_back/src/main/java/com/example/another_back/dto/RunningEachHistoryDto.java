package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

import java.util.Date;

@Data
public class RunningEachHistoryDto {
    private String id;
    private String runningTime;
    private Double runningDistance;
    private String userPace;
    private String createDate;
    private Integer userCalories;

    @Builder
    public RunningEachHistoryDto(String id, Integer runningTime, Float runningDistance, Float userPace, Date createDate, Integer userCalories) {
        this.id = id;
        this.runningTime = convertTime(Long.valueOf(runningTime));
        this.runningDistance = Math.round(runningDistance*1000)/1000.0;
        this.userPace = convertPace(Double.valueOf(userPace));
        this.createDate = new java.sql.Date(createDate.getTime()).toString();
        this.userCalories = userCalories;
    }
    private String convertTime(Long time) {
        String hour = Long.toString(time / 3600);
        time %= 3600;
        String minute = Long.toString(time / 60);
        String second = Long.toString(time % 60);
        if (hour.length() == 1) hour = "0" + hour;
        if (minute.length() == 1) minute = "0" + minute;
        if (second.length() == 1) second = "0" + second;


        return hour + ":" + minute + ":" + second;
    }

    private String convertPace(Double pace) {
        String minute = Integer.toString(pace.intValue() / 60);
        String second = Integer.toString(pace.intValue() % 60);
        return minute + "'" + second + "''";
    }
}

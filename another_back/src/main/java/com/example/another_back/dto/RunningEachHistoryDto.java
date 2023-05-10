package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

import java.util.Date;

@Data
public class RunningEachHistoryDto {
    private String id;
    private String runningTime;
    private Float runningDistance;
    private String userPace;
    private String createDate;
    private Integer userCalories;

    @Builder
    public RunningEachHistoryDto(String id, Integer runningTime, Float runningDistance,Float userPace, Date createDate, Integer userCalories) {
        String hour;
        String minute;
        String second;

        hour = Integer.toString(runningTime / 3600);
        runningTime %= 3600;
        minute = Integer.toString(runningTime / 60);
        second = Integer.toString(runningTime % 60);

        if(hour.length()==1)hour = "0"+hour;
        if(minute.length()==1)minute = "0"+minute;
        if(second.length()==1)second = "0"+second;

        this.id = id;
        this.runningTime = hour + ":" + minute + ":" + second;
        this.runningDistance = runningDistance;

        minute = Integer.toString(userPace.intValue()/60);
        second = Integer.toString(userPace.intValue()%60);

        this.userPace = minute+"'"+second+"''";
        this.createDate = new java.sql.Date(createDate.getTime()).toString();
        this.userCalories = userCalories;
    }
}

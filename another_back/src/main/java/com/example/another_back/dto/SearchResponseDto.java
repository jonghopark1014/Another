package com.example.another_back.dto;

import com.example.another_back.entity.Running;
import lombok.Builder;
import lombok.Getter;

import java.sql.Date;

@Getter
public class SearchResponseDto {
    private Long userId;
    private String runningId;
    private Integer runningTime;
    private Float runningDistance;
    private Date createDate;
    private Integer userCalories;
    private String runningPic;
    private Float userPace;

    @Builder
    public SearchResponseDto(Running running) {
        this.userId = running.getUser().getId();
        this.runningId = running.getId();
        this.runningTime = running.getRunningTime();
        this.runningDistance = running.getRunningDistance();
        this.createDate = running.getCreateDate();
        this.userCalories = running.getUserCalories();
        this.runningPic = "https://d37je0610e60il.cloudfront.net" + running.getRunningPic().split(".com")[1];
        this.userPace = running.getUserPace();
    }
}
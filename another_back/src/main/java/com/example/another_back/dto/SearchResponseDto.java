package com.example.another_back.dto;

import com.example.another_back.entity.Running;
import lombok.Builder;
import lombok.Getter;

import java.sql.Date;

@Getter
public class SearchResponseDto {
    private Long userId;
    private String runningId;
    private String runningTime;
    private Float runningDistance;
    private Date createDate;
    private Integer walkCount;
    private Integer kcal;
    private String runningPic;
    private Float speed;

    @Builder
    public SearchResponseDto(Running running) {
        this.userId = running.getUser().getId();
        this.runningId = running.getId();
        this.runningTime = running.getRunningTime();
        this.runningDistance = running.getRunningDistance();
        this.createDate = running.getCreateDate();
        this.walkCount = running.getWalkCount();
        this.kcal = running.getKcal();
        this.runningPic = running.getRunningPic();
        this.speed = running.getSpeed();
    }
}
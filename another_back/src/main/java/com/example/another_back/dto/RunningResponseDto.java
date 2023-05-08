package com.example.another_back.dto;

import com.example.another_back.entity.Running;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;


@Getter
@Setter
public class RunningResponseDto {
    private Long userId;
    private String runningId;
    private Integer runningTime;
    private Float runningDistance;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createDate;
    private Integer kcal;
    private String runningPic;
    private Float speed;

    @Builder
    public RunningResponseDto(Running running) {
        this.userId = running.getUser().getId();
        this.runningId = running.getId();
        this.runningTime = running.getRunningTime();
        this.runningDistance = running.getRunningDistance();
        this.createDate = running.getCreateDate();
        this.kcal = running.getKcal();
        this.runningPic = running.getRunningPic();
        this.speed = running.getSpeed()
        ;
    }
}

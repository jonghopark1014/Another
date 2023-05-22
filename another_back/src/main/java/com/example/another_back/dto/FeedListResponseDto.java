package com.example.another_back.dto;

import com.example.another_back.entity.Running;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
public class FeedListResponseDto {
    private String runningId;
    private String runningTime;
    private Float runningDistance;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createDate;
    private Integer userCalories;
    private String runningPic;
    private List<FeedPicResponseDto> feedPics;

    @Builder
    public FeedListResponseDto(Running running) {
        this.runningId = running.getId();
        this.runningTime = convertTime(running.getRunningTime());
        this.runningDistance = running.getRunningDistance();
        this.userCalories = running.getUserCalories();
        this.runningPic = "https://d37je0610e60il.cloudfront.net" + running.getRunningPic().split(".com")[1];
        this.feedPics = running.getFeedPic().stream().map(FeedPicResponseDto::new).collect(Collectors.toList());
    }

    private String convertTime(Integer time) {
        String hour = Long.toString(time / 3600);
        time %= 3600;
        String minute = Long.toString(time / 60);
        String second = Long.toString(time % 60);
        if (hour.length() == 1) hour = "0" + hour;
        if (minute.length() == 1) minute = "0" + minute;
        if (second.length() == 1) second = "0" + second;


        return hour + ":" + minute + ":" + second;
    }
}

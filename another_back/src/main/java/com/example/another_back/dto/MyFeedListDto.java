package com.example.another_back.dto;

import com.example.another_back.entity.Running;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
public class MyFeedListDto {
    private String runningId;
    private String runningTime;
    private Float runningDistance;
    private Integer userCalories;
    private String runningPic;
    private List<FeedPicResponseDto> feedPic;

    @Builder
    public MyFeedListDto(Running running) {
        this.runningId = running.getId();
        this.runningTime = convertTime(Long.valueOf(running.getRunningTime()));
        this.runningDistance = running.getRunningDistance();
        this.userCalories = running.getUserCalories();
        this.runningPic = running.getRunningPic();
        this.feedPic = running.getFeedPic().stream().map(FeedPicResponseDto::new).collect(Collectors.toList());
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
}

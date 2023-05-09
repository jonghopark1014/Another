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
    private Integer runningTime;
    private Float runningDistance;
    private Integer userCalories;
    private String runningPic;
    private List<FeedPicResponseDto> feedPic;

    @Builder
    public MyFeedListDto(Running running) {
        this.runningId = running.getId();
        this.runningTime = running.getRunningTime();
        this.runningDistance = running.getRunningDistance();
        this.userCalories = running.getUserCalories();
        this.runningPic = running.getRunningPic();
        this.feedPic = running.getFeedPic().stream().map(FeedPicResponseDto::new).collect(Collectors.toList());
    }
}

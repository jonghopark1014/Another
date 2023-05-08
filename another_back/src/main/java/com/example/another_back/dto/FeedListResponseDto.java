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
    private Integer runningTime;
    private Float runningDistance;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createDate;
    private Integer kcal;
    private String runningPic;
    private List<FeedPicResponseDto> feedPics;

    @Builder
    public FeedListResponseDto(Running running) {
        this.runningId = running.getId();
        this.runningTime = running.getRunningTime();
        this.runningDistance = running.getRunningDistance();
        this.kcal = running.getKcal();
        this.runningPic = running.getRunningPic();
        this.feedPics = running.getFeedPic().stream().map(FeedPicResponseDto::new).collect(Collectors.toList());
    }
}

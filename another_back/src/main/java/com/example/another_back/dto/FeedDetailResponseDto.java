package com.example.another_back.dto;

import com.example.another_back.entity.Running;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.json.simple.JSONArray;

import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
public class FeedDetailResponseDto {
    private String runningId;
    private Long withRunCount;
    private String nickname;
    private String profilePic;
    private Integer runningTime;
    private Float runningDistance;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createDate;
    private Integer kcal;
    private String runningPic;
    private Float speed;
    private List<FeedPicResponseDto> feedPics;
    private JSONArray graph;

    @Builder
    public FeedDetailResponseDto(Running running) {
        this.runningId = running.getId();
        this.nickname = running.getUser().getNickname();
        this.profilePic = running.getUser().getProfilePic();
        this.runningTime = running.getRunningTime();
        this.runningDistance = running.getRunningDistance();
        this.createDate = running.getCreateDate();
        this.kcal = running.getKcal();
        this.runningPic = running.getRunningPic();
        this.speed = running.getSpeed();
        this.feedPics = running.getFeedPic().stream().map(FeedPicResponseDto::new).collect(Collectors.toList());
    }
}

package com.example.another_back.dto;

import com.example.another_back.entity.Running;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
public class RunningResponseDto {
    private String runningId;
    private String runningTime;
    private Float runningDistance;
    private Integer walkCount;
    private String runningPic;
    private List<FeedPicResponsDto> feedPic;

    @Builder
    public RunningResponseDto(Running running) {
        this.runningId = running.getId();
        this.runningTime = running.getRunningTime();
        this.runningDistance = running.getRunningDistance();
        this.walkCount = running.getWalkCount();
        this.runningPic = running.getRunningPic();
        this.feedPic = running.getFeedPic().stream().map(FeedPicResponsDto::new).collect(Collectors.toList());
    }
}

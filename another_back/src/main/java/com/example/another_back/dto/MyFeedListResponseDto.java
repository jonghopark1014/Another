package com.example.another_back.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.domain.Page;

@Getter
@Setter
public class MyFeedListResponseDto {
    private String profilePic;
    private String runningTime;
    private Float runningDistance;
    private Integer userCalories;
    private Page<MyFeedListDto> myFeedListDtos;

    @Builder
    public MyFeedListResponseDto(String profilePic, Integer runningTime, Float runningDistance, Integer userCalories, Page<MyFeedListDto> myFeedListDtos) {
        this.profilePic = profilePic;
        this.runningTime = convertTime(Long.valueOf(runningTime));
        this.runningDistance = runningDistance;
        this.userCalories = userCalories;
        this.myFeedListDtos = myFeedListDtos;
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

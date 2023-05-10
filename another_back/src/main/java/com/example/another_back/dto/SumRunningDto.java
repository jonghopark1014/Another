package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

import java.util.Date;

@Data
public class SumRunningDto {
    private String sumTime;
    private Long sumKcal;
    private Double sumDistance;
    private String sumPace;
    private String startDate;
    private String endDate;

    public SumRunningDto() {
    }

    @Builder
    public SumRunningDto(Long sumTime, Long sumKcal, Double sumDistance, Double sumPace, Date startDate, Date endDate) {

        String hour;
        String minute;
        String second;

        hour = Long.toString(sumTime / 3600);
        sumTime %= 3600;
        minute = Long.toString(sumTime / 60);
        second = Long.toString(sumTime % 60);

        if(hour.length()==1)hour = "0"+hour;
        if(minute.length()==1)minute = "0"+minute;
        if(second.length()==1)second = "0"+second;
        this.sumTime = hour+ ":"+minute+":"+second;
        this.sumKcal = sumKcal;
        this.sumDistance = sumDistance;

        minute = Integer.toString(sumPace.intValue()/60);
        second = Integer.toString(sumPace.intValue()%60);

        this.sumPace = minute+"'"+second+"''";
        this.startDate = startDate.toString().substring(0,10);
        this.endDate = endDate.toString().substring(0,10);
    }
}

package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

import java.util.Date;

@Data
public class SumRunningDto {
    private String sumTime;
    private Long sumKcal;
    private Double sumDistance;
    private String avgPace;
    private String startDate;
    private String endDate;

    public SumRunningDto() {
    }

    @Builder
    public SumRunningDto(Long sumTime, Long sumKcal, Double sumDistance, Double avgPace, Date startDate, Date endDate) {
        if (sumTime == null) {
            this.sumTime = convertTime(0L);
            this.sumKcal = 0L;
            this.sumDistance = Math.round(0.0 * 1000) / 1000.0;
            this.avgPace = convertPace(0.0);
            this.startDate = new java.sql.Date(System.currentTimeMillis()).toString();
            this.endDate = new java.sql.Date(System.currentTimeMillis()).toString();
        } else {
            this.sumTime = convertTime(sumTime);
            this.sumKcal = sumKcal;
            this.sumDistance = Math.round(sumDistance * 1000) / 1000.0;
            this.avgPace = convertPace(avgPace);
            this.startDate = startDate.toString().substring(0, 10);
            this.endDate = endDate.toString().substring(0, 10);
        }
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

    private String convertPace(Double pace) {
        String minute = Integer.toString(pace.intValue() / 60);
        String second = Integer.toString(pace.intValue() % 60);
        return minute + "'" + second + "''";
    }

}

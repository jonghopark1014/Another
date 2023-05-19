package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RunningRecordDto {
    private Double avgRunningTime;
    private Double avgRunningDistance;
    private Double avgPace;
    private Double avgKcal;

    private Long sumRunningTime;
    private Double sumRunningDistance;
    private Double sumPace;
    private Long sumKcal;

    public RunningRecordDto(Double avgRunningTime, Double avgRunningDistance, Double avgPace, Double avgKcal, Long sumRunningTime, Double sumRunningDistance, Double sumPace, Long sumKcal) {
        this.avgRunningTime = avgRunningTime;
        this.avgRunningDistance = avgRunningDistance;
        this.avgPace = avgPace;
        this.avgKcal = avgKcal;
        this.sumRunningTime = sumRunningTime;
        this.sumRunningDistance = sumRunningDistance;
        this.sumPace = sumPace;
        this.sumKcal = sumKcal;
    }
}

package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

@Data
public class RunningHistoryResponseDto {
    private AvgRunningDto prevAvg;
    private CurRunningDto curAvg;

    @Builder
    public RunningHistoryResponseDto(AvgRunningDto prevAvg, CurRunningDto curAvg) {
        prevAvg.setAvgDistance(Math.round(prevAvg.getAvgDistance()*1000)/1000.0);
        curAvg.setAvgDistance(Math.round(curAvg.getAvgDistance()*1000)/1000.0);
        curAvg.setSumDistance(Math.round(curAvg.getSumDistance()*1000)/1000.0);
        this.prevAvg = prevAvg;
        this.curAvg = curAvg;
    }
}

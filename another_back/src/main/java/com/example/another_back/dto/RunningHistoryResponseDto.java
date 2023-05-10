package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

@Data
public class RunningHistoryResponseDto {
    private AvgRunningDto prevAvg;
    private CurRunningDto curAvg;

    @Builder
    public RunningHistoryResponseDto(AvgRunningDto prevAvg, CurRunningDto curAvg) {
        this.prevAvg = prevAvg;
        this.curAvg = curAvg;
    }
}

package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CurRunningDto {
    private String avgTime;
    private String avgPace;
    private Double avgKcal;
    private Double avgDistance;
    private Double originalPace;
    private Long originalTime;

    private String sumTime;
    private Long sumKcal;
    private Double sumDistance;
    private String startDate;
    private String endDate;
}

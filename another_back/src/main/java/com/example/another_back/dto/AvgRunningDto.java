package com.example.another_back.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AvgRunningDto {

    private String avgTime;
    private String avgPace;
    private Double avgKcal;
    private Double avgDistance;

}

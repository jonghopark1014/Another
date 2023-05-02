package com.example.another_back.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Date;


@Getter
@Setter
@NoArgsConstructor
public class RunningRequestDto {
    private Long userId;
    private String runningId;
    private String runningTime;
    private Float runningDistance;
    private Date createDate;
    private Integer walkCount;
    private Integer kcal;
    private Float speed;
    private MultipartFile runningPic;

    @Builder
    public RunningRequestDto(Long userId, String runningId, String runningTime, Float runningDistance, Date createDate, Integer walkCount, Integer kcal, Float speed, MultipartFile runningPic) {
        this.userId = userId;
        this.runningId = runningId;
        this.runningTime = runningTime;
        this.runningDistance = runningDistance;
        this.createDate = createDate;
        this.walkCount = walkCount;
        this.kcal = kcal;
        this.speed = speed;
        this.runningPic = runningPic;
    }
}
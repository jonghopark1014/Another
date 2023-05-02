package com.example.another_back.entity;

import com.example.another_back.dto.RunningRequestDto;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Running {

    @Column(name =  "running_id")
    @Id
    private String id;

    private String runningTime;
    private Float runningDistance;
    private Date createDate;
    private Integer walkCount;
    private Integer kcal;
    private String runningPic;
    private Float speed;
    private enum status{
        LIVE, DELETE
    }
    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    @OneToMany(mappedBy = "running", cascade = CascadeType.ALL)
    private List<FeedPic> feedPic = new ArrayList<>();

    @OneToMany(mappedBy = "runningHost")
    private List<WithRun> withRunList = new ArrayList<>();

    @ManyToOne(fetch = FetchType.LAZY)
    private WithRun withRun;


    @Builder
    public Running(RunningRequestDto runningRequestDto,String runningPic,User user) {
        this.id = runningRequestDto.getRunningId();
        this.user = user;
        this.runningTime = runningRequestDto.getRunningTime();
        this.runningDistance = runningRequestDto.getRunningDistance();
        this.createDate = runningRequestDto.getCreateDate();
        this.walkCount = runningRequestDto.getWalkCount();
        this.kcal = runningRequestDto.getKcal();
        this.runningPic = runningPic;
        this.speed = runningRequestDto.getSpeed();
    }
}

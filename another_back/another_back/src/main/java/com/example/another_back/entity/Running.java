package com.example.another_back.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Running {

    @Column(name =  "running_id")
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Timestamp runningTime;
    private Float runningDistance;
    private Date createDate;
    private Integer walkCount;
    private Integer kcal;
    private String runningPic;
    private Float speed;
    private enum status{
        LIVE, DELETE
    }

    @OneToMany(mappedBy = "running")
    private List<FeedPic> feedPic = new ArrayList<>();

    @OneToMany(mappedBy = "runningHost")
    private List<WithRun> withRunList = new ArrayList<>();

    @ManyToOne(fetch = FetchType.LAZY)
    private WithRun withRun;
}

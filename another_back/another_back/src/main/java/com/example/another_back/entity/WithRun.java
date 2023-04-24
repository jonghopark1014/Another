package com.example.another_back.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class WithRun {

    @Column(name = "with_run_id")
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    private Running runningHost;

    @OneToMany(mappedBy = "withRun")
    private List<Running> runningSlaves = new ArrayList<>();
}

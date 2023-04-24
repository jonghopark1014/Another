package com.example.another_back.entity;

import lombok.Getter;

import javax.persistence.*;

@Entity
@Getter
public class FeedPic {

    @Column(name = "feedPic_id")
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    private String feedPic;

    @ManyToOne(fetch = FetchType.LAZY)
    private Running running;
}

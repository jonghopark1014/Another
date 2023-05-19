package com.example.another_back.entity;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class FeedPic {

    @Column(name = "feed_pic_id")
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String feedPic;

    @ManyToOne(fetch = FetchType.LAZY)
    private Running running;

    @Builder
    public FeedPic(String feedPic, Running running) {
        this.feedPic = feedPic;
        this.running = running;
    }
}

package com.example.another_back.dto;

import com.example.another_back.entity.FeedPic;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FeedPicResponseDto {
    private Long feedPicId;
    private String feedPic;

    @Builder
    public FeedPicResponseDto(FeedPic feedPic) {
        this.feedPicId = feedPic.getId();
        this.feedPic = feedPic.getFeedPic();
    }
}

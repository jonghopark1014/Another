package com.example.another_back.dto;

import com.example.another_back.entity.FeedPic;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FeedPicResponsDto {
    private Long feedPicId;
    private String feedPic;

    @Builder
    public FeedPicResponsDto(FeedPic feedPic) {
        this.feedPicId = feedPic.getId();
        this.feedPic = feedPic.getFeedPic();
    }
}

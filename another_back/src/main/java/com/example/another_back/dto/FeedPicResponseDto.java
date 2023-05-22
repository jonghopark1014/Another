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
        if (!feedPic.getFeedPic().equals(null))
            this.feedPic = "https://d37je0610e60il.cloudfront.net" + feedPic.getFeedPic().split(".com")[1];
    }
}

package com.example.another_back.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.domain.Page;

@Getter
@Setter
public class MyFeedListResponseDto {
    private String profilePic;
    private Page<MyFeedListDto> myFeedListDtos;

    @Builder
    public MyFeedListResponseDto(String profilePic, Page<MyFeedListDto> myFeedListDtos) {
        this.profilePic = profilePic;
        this.myFeedListDtos = myFeedListDtos;
    }
}

package com.example.another_back.dto;

import com.example.another_back.entity.WithRun;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WithRunResponseDto {
    private Long userId;
    private String nickname;
    private String profilePic;

    @Builder
    public WithRunResponseDto(WithRun withRun) {
        this.userId = withRun.getRunningHost().getUser().getId();
        this.nickname = withRun.getRunningHost().getUser().getNickname();
        this.profilePic = withRun.getRunningHost().getUser().getProfilePic();
    }
}

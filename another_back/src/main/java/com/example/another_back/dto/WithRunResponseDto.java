package com.example.another_back.dto;

import com.example.another_back.entity.Running;
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
    public WithRunResponseDto(Running running) {
        this.userId = running.getUser().getId();
        this.nickname = running.getUser().getNickname();
        this.profilePic = running.getUser().getProfilePic();
    }
}

package com.example.another_back.dto.badge;

import com.example.another_back.entity.Challenge;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EndChallengeResponseDto {
    private Long challengeId;
    private String challengeName;
    private String challengeUrl;

    @Builder
    public EndChallengeResponseDto(Challenge challenge) {
        this.challengeId = challenge.getId();
        this.challengeName = challenge.getChallengeName();
        this.challengeUrl = challenge.getChallengeGold();
    }
}

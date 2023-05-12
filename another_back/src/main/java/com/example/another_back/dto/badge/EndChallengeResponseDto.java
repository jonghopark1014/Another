package com.example.another_back.dto.badge;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EndChallengeResponseDto {
    private String runningId;
    private Long challengeId;
    private String challengeName;
    private String challengeUrl;

    @Builder
    public EndChallengeResponseDto(String runningId, Long challengeId, String challengeName, String challengeUrl) {
        this.runningId = runningId;
        this.challengeId = challengeId;
        this.challengeName = challengeName;
        this.challengeUrl = challengeUrl;
    }
}

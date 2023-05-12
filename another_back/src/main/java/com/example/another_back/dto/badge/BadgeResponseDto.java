package com.example.another_back.dto.badge;

import com.example.another_back.entity.UserChallenge;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BadgeResponseDto {
    private Integer challengeCategory;
    private String challengeName;
    private Double challengeValue;
    private String challengeUrl;

    @Builder
    public BadgeResponseDto(UserChallenge userChallenge) {
        this.challengeCategory = userChallenge.getChallenge().getChallengeCategory();
        this.challengeName = userChallenge.getChallenge().getChallengeName();
        if (userChallenge.getStatus().equals("SILVER")) {
            this.challengeUrl = userChallenge.getChallenge().getChallengeSilver();
            this.challengeValue = Double.valueOf((double) userChallenge.getChallenge().getChallengeTarget() / userChallenge.getUserChallengeValue());
            if (challengeValue.isInfinite())
                this.challengeValue = 0d;
        } else {
            this.challengeUrl = userChallenge.getChallenge().getChallengeGold();
            this.challengeValue = 1d;
        }
    }
}

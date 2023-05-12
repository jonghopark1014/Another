package com.example.another_back.dto.badge;

import com.example.another_back.entity.UserChallenge;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AllBadgeResponseDto {
    private Integer challengeCategory;
    private String challengeName;
    private Integer userChallengeValue;
    private Integer challengeTarget;
    private String challengeUrl;

    @Builder
    public AllBadgeResponseDto(UserChallenge userChallenge) {
        this.challengeCategory = userChallenge.getChallenge().getChallengeCategory();
        this.challengeName = userChallenge.getChallenge().getChallengeName();
        this.userChallengeValue = userChallenge.getUserChallengeValue();
        this.challengeTarget = userChallenge.getChallenge().getChallengeTarget();
        if (userChallenge.getStatus().equals("SILVER"))
            this.challengeUrl = userChallenge.getChallenge().getChallengeSilver();
        else
            this.challengeUrl = userChallenge.getChallenge().getChallengeGold();
    }
}

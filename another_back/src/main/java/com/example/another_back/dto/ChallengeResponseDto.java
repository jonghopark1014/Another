package com.example.another_back.dto;

import com.example.another_back.entity.Challenge;
import lombok.Builder;
import lombok.Getter;

@Getter
public class ChallengeResponseDto {
    private Long challengeId;
    private String challengeName;
    private Integer challengeTarget;
    private String challengeDesc;
    private String challengeGold;
    private Integer challengeCategory;

    @Builder
    public ChallengeResponseDto(Challenge challenge) {
        this.challengeId = challenge.getId();
        this.challengeName = challenge.getChallengeName();
        this.challengeTarget = challenge.getChallengeTarget();
        this.challengeDesc = challenge.getChallengeDesc();
        this.challengeGold = challenge.getChallengeGold();
        this.challengeCategory = challenge.getChallengeCategory();
    }
}

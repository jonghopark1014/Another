package com.example.another_back.dto.running;

import com.example.another_back.dto.badge.EndChallengeResponseDto;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class EndRunningDto {
    private String runningId;
    private List<EndChallengeResponseDto> endChallengeResponseDtoList;

    @Builder
    public EndRunningDto(String runningId, List<EndChallengeResponseDto> endChallengeResponseDtoList) {
        this.runningId = runningId;
        this.endChallengeResponseDtoList = endChallengeResponseDtoList;
    }
}
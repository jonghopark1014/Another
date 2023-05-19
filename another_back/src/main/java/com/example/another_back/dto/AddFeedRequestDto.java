package com.example.another_back.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AddFeedRequestDto {
    private Long userId;
    private String runningId;
}

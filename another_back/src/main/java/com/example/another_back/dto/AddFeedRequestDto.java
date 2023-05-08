package com.example.another_back.dto;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
public class AddFeedRequestDto {
    private Long userId;
    private String runningId;
    private List<MultipartFile> feedPics;
}

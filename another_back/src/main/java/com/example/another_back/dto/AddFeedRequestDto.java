package com.example.another_back.dto;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
public class AddFeedRequestDto {
    private Long userId;
    private String runningId;
    private MultipartFile[] feedPics;

    public int feedPicsLength() {
        if (feedPics == null)
            return 0;
        else
            return 1;
    }
}

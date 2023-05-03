package com.example.another_back.controller;

import com.example.another_back.dto.FeedListResponseDto;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.FeedService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/feed")
public class FeedController {

    private final FeedService feedService;

    /**
     * 피드 리스트 기능
     *
     * @param pageable
     * @return Page<RunningResponseDto>
     */
    @GetMapping
    public ResponseEntity getFeedList(Pageable pageable) {
        Page<FeedListResponseDto> feedList = feedService.getFeedList(pageable);
        return Response.success(HttpStatus.OK, feedList);
    }

    /**
     * 내 피드만 가져오기
     *
     * @param userId
     * @param pageable
     * @return Page<FeedListResponseDto>
     */
    @GetMapping("/{userId}")
    public ResponseEntity getMyFeedList(@PathVariable Long userId, Pageable pageable) {
        Page<FeedListResponseDto> feedList = feedService.getMyFeedList(userId, pageable);
        return Response.success(HttpStatus.OK, feedList);
    }

    /**
     * 예외 발생 처리
     *
     * @param e
     * @return error
     */
    @ExceptionHandler(IllegalStateException.class)
    public ResponseEntity illegalStateException(IllegalStateException e) {
        return Response.fail(HttpStatus.BAD_REQUEST, e.getMessage());
    }
}

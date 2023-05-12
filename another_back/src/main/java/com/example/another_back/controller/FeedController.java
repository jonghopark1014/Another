package com.example.another_back.controller;

import com.example.another_back.dto.*;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.FeedService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/feed")
public class FeedController {

    private final FeedService feedService;

    /**
     * 오운완 등록
     *
     * @param addFeedRequestDto
     * @return String
     * @throws IOException
     */
    @PostMapping(value = "/create", consumes =
            {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity addFeed(@RequestPart AddFeedRequestDto addFeedRequestDto, @RequestPart MultipartFile[] feedPics) throws IOException {
        String response = feedService.addFeed(addFeedRequestDto, feedPics);
        return Response.success(HttpStatus.OK, response);
    }

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
     * @return MyFeedListResponseDto
     */
    @GetMapping("/{userId}")
    public ResponseEntity getMyFeedList(@PathVariable Long userId, Pageable pageable) {
        MyFeedListResponseDto feedList = feedService.getMyFeedList(userId, pageable);
        return Response.success(HttpStatus.OK, feedList);
    }

    /**
     * 피드 디테일 가져오기
     *
     * @param runningId
     * @return FeedDetailResponseDto
     */
    @GetMapping("/detail/{runningId}")
    public ResponseEntity getFeedDetail(@PathVariable String runningId) {
        FeedDetailResponseDto feedDetail = feedService.getFeedDetail(runningId);
        return Response.success(HttpStatus.OK, feedDetail);
    }

    /**
     * WithRun 목록 가져오기
     *
     * @param runningId
     * @return List<WithRunResponseDto>
     */
    @GetMapping("/detail/withRun/{runningId}")
    public ResponseEntity getWithRunList(@PathVariable String runningId) {
        List<WithRunResponseDto> response = feedService.getWithRunList(runningId);
        return Response.success(HttpStatus.OK, response);
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

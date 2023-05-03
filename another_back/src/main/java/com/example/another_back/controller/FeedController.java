package com.example.another_back.controller;

import com.example.another_back.dto.FeedListResponseDto;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.FeedService;
import lombok.RequiredArgsConstructor;
import org.json.simple.JSONArray;
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
     * 디테일 페이지 그래프에 사용할 데이터 반환
     *
     * @param runningId
     * @return JSONArray
     */
    @GetMapping("/{runningId}")
    public ResponseEntity getOriginData(@PathVariable String runningId) {
        JSONArray response = feedService.getOringinData(runningId);
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

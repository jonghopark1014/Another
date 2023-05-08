package com.example.another_back.controller;

import com.example.another_back.dto.RunningResponseDto;
import com.example.another_back.dto.SearchRequestDto;
import com.example.another_back.dto.SearchResponseDto;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.VersusService;
import lombok.RequiredArgsConstructor;
import org.json.simple.JSONArray;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/versus")
public class VersusController {

    private final VersusService versusService;

    /**
     * 경쟁 시작
     *
     * @param runningId
     * @return JSONArray
     */
    @GetMapping("/{runningId}")
    public ResponseEntity getVersusData(@PathVariable String runningId) {
        JSONArray response = versusService.getVersusData(runningId);
        return Response.success(HttpStatus.OK, response);
    }

    /**
     * 내 기록 가져오기
     *
     * @param userId
     * @param pageable
     * @return Page<RunningResponseDto>
     */
    @GetMapping("/record/{userId}/myrecord")
    public ResponseEntity getMyRecord(@PathVariable Long userId, Pageable pageable) {
        Page<RunningResponseDto> response = versusService.getMyRecord(userId, pageable);
        return Response.success(HttpStatus.OK, response);
    }

    /**
     * 비슷한 목표 가져오기(안쓰는 기능)
     *
     * @param searchRequestDto
     * @param pageable
     * @return Page<SearchResponseDto>
     */
//    @PostMapping("/record/search")
//    public ResponseEntity getSearchRecord(@RequestBody SearchRequestDto searchRequestDto, Pageable pageable) {
//        Page<SearchResponseDto> response = versusService.getSearchRecord(searchRequestDto, pageable);
//        return Response.success(HttpStatus.OK, response);
//    }

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

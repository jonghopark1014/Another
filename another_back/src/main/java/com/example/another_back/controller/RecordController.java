package com.example.another_back.controller;

import com.example.another_back.dto.RunningEachHistoryDto;
import com.example.another_back.dto.RunningHistoryResponseDto;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.RunningService;
import com.example.another_back.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/record")
public class RecordController {

    private final UserService userService;
    private final RunningService runningService;

    @GetMapping("/{userId}")
    public ResponseEntity getUserLevelExp(@PathVariable("userId")Long userId) {
        return Response.success(HttpStatus.OK, userService.getUserLevelExp(userId));
    }

    @GetMapping("/{userId}/today")
    public ResponseEntity getTodayRecord(@PathVariable("userId")Long userId){
        RunningHistoryResponseDto record = runningService.getRecord(1, userId);
        return Response.success(HttpStatus.OK, record);
    }
    @GetMapping("/{userId}/history/today")
    public ResponseEntity getTodayHisotry(@PathVariable("userId")Long userId, Pageable pageable){
        Page<RunningEachHistoryDto> record = runningService.getHistory(1, userId, pageable);
        return Response.success(HttpStatus.OK, record);
    }
    @GetMapping("/{userId}/week")
    public ResponseEntity getWeekRecord(@PathVariable("userId")Long userId){
        RunningHistoryResponseDto record = runningService.getRecord(2, userId);
        return Response.success(HttpStatus.OK, record);
    }
    @GetMapping("/{userId}/history/week")
    public ResponseEntity getWeekHisotry(@PathVariable("userId")Long userId, Pageable pageable){
        Page<RunningEachHistoryDto> record = runningService.getHistory(2, userId, pageable);
        return Response.success(HttpStatus.OK, record);
    }
    @GetMapping("/{userId}/month")
    public ResponseEntity getMonthRecord(@PathVariable("userId")Long userId){
        RunningHistoryResponseDto record = runningService.getRecord(3, userId);
        return Response.success(HttpStatus.OK, record);
    }

    @GetMapping("/{userId}/history/month")
    public ResponseEntity getMonthHisotry(@PathVariable("userId")Long userId, Pageable pageable){
        Page<RunningEachHistoryDto> record = runningService.getHistory(3, userId, pageable);
        return Response.success(HttpStatus.OK, record);
    }
}

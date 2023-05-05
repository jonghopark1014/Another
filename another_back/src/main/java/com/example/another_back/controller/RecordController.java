package com.example.another_back.controller;

import com.example.another_back.dto.DateIntervalDto;
import com.example.another_back.dto.RunningHistoryResponseDto;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.RunningService;
import com.example.another_back.service.UserService;
import lombok.RequiredArgsConstructor;
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
    public ResponseEntity getTodayRecord(@PathVariable("userId")Long userId, Pageable pageable){
        RunningHistoryResponseDto record = runningService.getRecord(1, userId, null, null, pageable);
        return Response.success(HttpStatus.OK, record);
    }
    @GetMapping("/{userId}/week")
    public ResponseEntity getWeekRecord(@PathVariable("userId")Long userId, Pageable pageable){
        RunningHistoryResponseDto record = runningService.getRecord(2, userId, null, null, pageable);
        return Response.success(HttpStatus.OK, record);
    }
    @GetMapping("/{userId}/month")
    public ResponseEntity getMonthRecord(@PathVariable("userId")Long userId, Pageable pageable){
        RunningHistoryResponseDto record = runningService.getRecord(3, userId, null, null, pageable);
        return Response.success(HttpStatus.OK, record);
    }
    @GetMapping("/{userId}/all")
    public ResponseEntity getTotalRecord(@PathVariable("userId")Long userId, Pageable pageable){
        RunningHistoryResponseDto record = runningService.getRecord(4, userId, null, null, pageable);
        return Response.success(HttpStatus.OK, record);
    }
    @GetMapping("/{userId}/interval")
    public ResponseEntity getIntervalRecord(@PathVariable("userId")Long userId, @RequestBody DateIntervalDto dateIntervalDto, Pageable pageable){
        RunningHistoryResponseDto record = runningService.getRecord(5, userId, dateIntervalDto.getStartDate(), dateIntervalDto.getEndDate(), pageable);
        return Response.success(HttpStatus.OK, record);
    }
}

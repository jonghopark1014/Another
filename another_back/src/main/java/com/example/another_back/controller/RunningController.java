package com.example.another_back.controller;

import com.example.another_back.dto.RunningRequestDto;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.RunningService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/run")
public class RunningController {

    private final RunningService runningService;

    /**
     * 러닝 종료
     *
     * @param runningRequestDto
     * @param runningPic
     *
     * @return success
     */
    @PostMapping("/stop")
    public ResponseEntity addRunning(@RequestPart RunningRequestDto runningRequestDto, @RequestPart MultipartFile runningPic){
        runningService.addRunning(runningRequestDto, runningPic);
        return Response.success(HttpStatus.OK);
    }
}

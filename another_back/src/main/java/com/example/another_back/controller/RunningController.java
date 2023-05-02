package com.example.another_back.controller;

import com.example.another_back.dto.RunningRequestDto;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.RunningService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/run")
public class RunningController {

    private final RunningService runningService;

    /**
     * 러닝 종료
     *
     * @param runningRequestDto
     *
     * @return success
     */
    @PostMapping("/stop")
    public ResponseEntity addRunning(RunningRequestDto runningRequestDto){
        runningService.addRunning(runningRequestDto);
        return Response.success(HttpStatus.OK);
    }
}

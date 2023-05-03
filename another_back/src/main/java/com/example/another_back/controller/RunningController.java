package com.example.another_back.controller;

import com.example.another_back.dto.RunningRequestDto;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.RunningService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/run")
public class RunningController {

    private final RunningService runningService;

    /**
     * 러닝 종료
     *
     * @param runningRequestDto
     * @return success
     */
    @PostMapping(value = "/stop", consumes =
            {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity addRunning(RunningRequestDto runningRequestDto) {
        runningService.addRunning(runningRequestDto);
        return Response.success(HttpStatus.OK);
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

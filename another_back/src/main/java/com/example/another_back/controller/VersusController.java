package com.example.another_back.controller;

import com.example.another_back.dto.Response;
import com.example.another_back.service.VersusService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
    public ResponseEntity getVersusData(@PathVariable String runningId){
        return Response.success(HttpStatus.OK,versusService.getVersusData(runningId));
    }
}

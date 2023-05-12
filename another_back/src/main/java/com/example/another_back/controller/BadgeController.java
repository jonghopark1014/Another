package com.example.another_back.controller;

import com.example.another_back.dto.badge.AllBadgeResponseDto;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.BadgeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/badge")
public class BadgeController {
    private final BadgeService badgeService;

    /**
     * 사용자에 관련된 모든 뱃지 정보 가져오기
     *
     * @param userId
     * @return List<AllBadgeResponseDto>
     */
    @GetMapping("/all/{userId}")
    public ResponseEntity getAllBadge(@PathVariable Long userId){
        List<AllBadgeResponseDto> response = badgeService.getAllBadge(userId);
        return Response.success(HttpStatus.OK, response);
    }
}

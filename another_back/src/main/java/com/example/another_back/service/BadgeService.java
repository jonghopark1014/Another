package com.example.another_back.service;

import com.example.another_back.dto.badge.AllBadgeResponseDto;
import com.example.another_back.entity.User;
import com.example.another_back.entity.UserChallenge;
import com.example.another_back.repository.UserChallengeRepository;
import com.example.another_back.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BadgeService {
    private final UserRepository userRepository;
    private final UserChallengeRepository userChallengeRepository;

    /**
     * 사용자에 관련된 모든 뱃지 정보 가져오기
     *
     * @param userId
     * @return List<AllBadgeResponseDto>
     */
    public List<AllBadgeResponseDto> getAllBadge(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new IllegalArgumentException("Badge Service: 유저를 찾지 못했습니다."));
        List<UserChallenge> userChallenge = userChallengeRepository.findByUser(user);
        List<AllBadgeResponseDto> response = userChallenge.stream().map(x -> AllBadgeResponseDto.builder().userChallenge(x).build()).collect(Collectors.toList());
        return response;
    }
}

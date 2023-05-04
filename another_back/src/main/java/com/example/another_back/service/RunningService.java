package com.example.another_back.service;

import com.example.another_back.dto.ChallengeResponseDto;
import com.example.another_back.dto.MonthDistanceResponseDto;
import com.example.another_back.dto.RunningRequestDto;
import com.example.another_back.entity.Challenge;
import com.example.another_back.entity.Running;
import com.example.another_back.entity.User;
import com.example.another_back.repository.RunningRepository;
import com.example.another_back.repository.UserChallengeRepository;
import com.example.another_back.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.sql.Date;
import java.util.Calendar;

@Service
@RequiredArgsConstructor
@Slf4j
public class RunningService {

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    private final RunningRepository runningRepository;

    private final UserRepository userRepository;

    private final UserChallengeRepository userChallengeRepository;

    private final S3UploaderService s3UploaderService;

    /**
     * 러닝 종료
     *
     * @param runningRequestDto
     * @return String
     */
    public String addRunning(RunningRequestDto runningRequestDto) {
        // 러닝 PK 유효성 검사
        checkDuplicatedRunning(runningRequestDto.getRunningId());
        // User 유효성 검사
        User user = userRepository.findById(runningRequestDto.getUserId())
                .orElseThrow(() -> new IllegalArgumentException("유저가 비어있습니다."));
        // 러닝 루트 S3 업로드
        String runningPic = null;
        try {
            runningPic = s3UploaderService.upload(runningRequestDto.getRunningPic(), bucket, "image");
        } catch (IOException e) {
            new IllegalArgumentException("S3 파일 업로드 중 에러가 발생했습니다.");
        }
        // 러닝 객체 생성
        Running running = new Running(runningRequestDto, runningPic, user);
        // DB에 저장
        Running savedRunning = runningRepository.save(running);
        // Id 반환
        return savedRunning.getId();
    }

    /**
     * 러닝데이터 유효성 검사
     *
     * @param runningId
     */
    private void checkDuplicatedRunning(String runningId) {
        if (!runningRepository.findById(runningId).isEmpty()) {
            throw new IllegalArgumentException("이미 러닝데이터가 등록되었습니다.");
        }
    }

    /**
     * 저번달 vs 이번달 거리 데이터
     *
     * @param userId
     * @return MonthDistanceResponseDto
     */
    public MonthDistanceResponseDto getMonthData(Long userId) {
        Calendar curCal = Calendar.getInstance();

        // 이번달
        curCal.set(curCal.DATE, 1);
        Date startDate = new Date(curCal.getTimeInMillis());
        curCal.set(curCal.DATE, curCal.getActualMaximum(curCal.DATE));
        Date endDate = new Date(curCal.getTimeInMillis());
        Float thisMonthDistance = runningRepository.SumRunningDistanceByUserIdAndCreateDateBetween(userId, startDate, endDate)
                .orElseThrow(() -> new IllegalArgumentException("이번달 기록을 가져오는데 실패했습니다."));

        // 지난달
        curCal.add(curCal.MONTH, -1);
        curCal.set(curCal.DATE, 1);
        startDate = new Date(curCal.getTimeInMillis());
        curCal.set(curCal.DATE, curCal.getActualMaximum(curCal.DATE));
        endDate = new Date(curCal.getTimeInMillis());
        Float lastMonthDistance = runningRepository.SumRunningDistanceByUserIdAndCreateDateBetween(userId, startDate, endDate)
                .orElseThrow(() -> new IllegalArgumentException("저번달 기록을 가져오는데 실패했습니다."));

        MonthDistanceResponseDto response = new MonthDistanceResponseDto(thisMonthDistance, lastMonthDistance);
        return response;
    }

    /**
     * 챌린지 추천
     *
     * @param userId
     * @return ChallengeResponseDto
     */
    public ChallengeResponseDto getRecommendChallenge(Long userId) {
        Challenge challenge = userChallengeRepository.findTop1ByUserAndStatusNotaAndWithChallenge(userId, "silver");
        if (challenge == null) return null;
        ChallengeResponseDto response = new ChallengeResponseDto(challenge);
        return response;
    }
}

package com.example.another_back.service;

import com.example.another_back.dto.*;
import com.example.another_back.entity.Challenge;
import com.example.another_back.entity.Running;
import com.example.another_back.entity.User;
import com.example.another_back.repository.RunningRepository;
import com.example.another_back.repository.UserChallengeRepository;
import com.example.another_back.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.annotation.Nullable;
import java.io.IOException;
import java.sql.Date;
import java.util.Calendar;
import java.util.List;

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
        List<String> runningPic = null;
        try {
            runningPic = s3UploaderService.upload(bucket, "image",runningRequestDto.getRunningPic());
        } catch (IOException e) {
            throw new IllegalArgumentException("S3 파일 업로드 중 에러가 발생했습니다.");
        }
        // 러닝 객체 생성
        Running running = new Running(runningRequestDto, runningPic.get(0), user);
        // DB에 저장
        Running savedRunning = runningRepository.save(running);
        // Id 반환
        return savedRunning.getId();
    }

    public RunningHistoryResponseDto getRecord(int category, Long userId, @Nullable Date date1, @Nullable Date date2, Pageable pageable) {
        Calendar calendar1 = Calendar.getInstance();
        Calendar calendar2 = Calendar.getInstance();
        Date startDate, endDate;
        Page<RunningEachHistoryDto> runData;
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 유저가 존재하지 않습니다."));
        //오늘
        if (category == 1) {
            startDate = new Date(calendar1.getTimeInMillis());
            endDate = new Date(calendar1.getTimeInMillis());
            runData = runningRepository.findWithDateByUserId(user, startDate, endDate, pageable);
        } else if (category == 2) {
            calendar1.set(calendar1.DATE, calendar1.getFirstDayOfWeek());
            calendar2.set(calendar1.DATE, calendar1.getFirstDayOfWeek() + 7);

            startDate = new Date(calendar1.getTimeInMillis());
            endDate = new Date(calendar2.getTimeInMillis());

            runData = runningRepository.findWithDateByUserId(user, startDate, endDate, pageable);
        } else if (category == 3) {
            calendar1.set(calendar1.DATE, 1);
            calendar2.set(calendar1.DATE, calendar1.getActualMaximum(calendar1.DAY_OF_MONTH));

            startDate = new Date(calendar1.getTimeInMillis());
            endDate = new Date(calendar2.getTimeInMillis());

            runData = runningRepository.findWithDateByUserId(user, startDate, endDate, pageable);
        } else if (category == 4) {
            startDate = new Date(1,1,1);
            endDate = new Date(System.currentTimeMillis());
            runData = runningRepository.findWithDateByUserId(user, startDate, endDate, pageable);
        } else {
            startDate = date1;
            endDate = date2;
            runData = runningRepository.findWithDateByUserId(user, startDate, endDate, pageable);
        }
        RunningHistoryDto runningHistoryDto =
                runningRepository.findRunningHistoryDtoByUserId(user, startDate, endDate).orElse(new RunningHistoryDto(0L,0D,0L,0L));
        long hour = 0;
        long minute = 0;
        long second = 0;

        Long time = runningHistoryDto.getRunningTime();
        hour = time/3600;
        time %=3600;
        minute = time/60;
        second = time%60;

        String runningTime = Long.toString(hour)
                + ":" + Long.toString(minute) + ":" + Long.toString(second);
        return RunningHistoryResponseDto.builder()
                .dayOfRunning(runningHistoryDto.getDayOfRunning())
                .runningTime(runningTime)
                .runningDistance(runningHistoryDto.getRunningDistance())
                .kcal(runningHistoryDto.getKcal())
                .runningData(runData)
                .build();
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

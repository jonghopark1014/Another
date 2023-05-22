package com.example.another_back.service;

import com.example.another_back.dto.*;
import com.example.another_back.dto.badge.EndChallengeResponseDto;
import com.example.another_back.dto.running.EndRunningDto;
import com.example.another_back.entity.*;
import com.example.another_back.repository.RunningRepository;
import com.example.another_back.repository.UserChallengeRepository;
import com.example.another_back.repository.UserRepository;
import com.example.another_back.repository.WithRunRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
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

    private final WithRunRepository withRunRepository;

    private final S3UploaderService s3UploaderService;

    /**
     * 러닝 종료
     *
     * @param runningRequestDto
     * @return EndRunningDto
     */
    public EndRunningDto addRunning(RunningRequestDto runningRequestDto) {
        // 러닝 PK 유효성 검사
        checkDuplicatedRunning(runningRequestDto.getRunningId());
        // User 유효성 검사
        User user = userRepository.findById(runningRequestDto.getUserId())
                .orElseThrow(() -> new IllegalArgumentException("유저가 비어있습니다."));
        // 러닝 루트 S3 업로드
        List<String> runningPic = null;
        try {
            runningPic = s3UploaderService.upload(bucket, "image", runningRequestDto.getRunningPic());
        } catch (IOException e) {
            throw new IllegalArgumentException("S3 파일 업로드 중 에러가 발생했습니다.");
        }
        // 러닝 객체 생성
        Running running = new Running(runningRequestDto, runningPic.get(0), user);
        if (runningRequestDto.getHostRunningId() != null) {
            WithRun withRun = withRunRepository.findByRunningHostId(runningRequestDto.getHostRunningId())
                    .orElseThrow(() -> new IllegalArgumentException("With Run 을 가져오는 중 에러가 발생했습니다."));
            running.setWithRun(withRun);
        }
        // DB에 저장
        Running savedRunning = runningRepository.save(running);
        // 경험치 체크
        int runningDistance = 0;
        int runningTime = 0;
        int checkTime = Math.toIntExact(runningRepository.SumRunningTimeByUserId(user.getId()).orElse(0L));
        runningDistance = runningRepository.SumRunningDistanceByUserId(user.getId()).orElse(0D).intValue();
        runningTime = checkTime / 600;
        int exp = runningDistance + runningTime;
        // level 체크
        if (!(user.getExp() >= 166660)) {
            if (exp >= 166660) {
                user.setLevel(10);
                user.setExp(exp - 166660);
            } else if (exp >= 66660) {
                user.setLevel(9);
                user.setExp(exp - 66660);
            } else if (exp >= 16660) {
                user.setLevel(8);
                user.setExp(exp - 16660);
            } else if (exp >= 6660) {
                user.setLevel(7);
                user.setExp(exp - 6660);
            } else if (exp >= 1660) {
                user.setLevel(6);
                user.setExp(exp - 1660);
            } else if (exp >= 660) {
                user.setLevel(5);
                user.setExp(exp - 660);
            } else if (exp >= 160) {
                user.setLevel(4);
                user.setExp(exp - 160);
            } else if (exp >= 60) {
                user.setLevel(3);
                user.setExp(exp - 60);
            } else if (exp >= 10) {
                user.setLevel(2);
                user.setExp(exp - 10);
            } else if (exp >= 0) {
                user.setLevel(1);
                user.setExp(exp);
            }
        }
        List<EndChallengeResponseDto> endChallengeResponseDtoList = new ArrayList<>();
        for (UserChallenge userChallenge :
                user.getUserChallengeList()) {
            if (userChallenge.getStatus().equals("GOLD")) continue;
            int category = userChallenge.getChallenge().getChallengeCategory();
            switch (category) {
                case 1:
                    userChallenge.setUserChallengeValue(checkTime / 60);
                    if (userChallenge.getUserChallengeValue() >= userChallenge.getChallenge().getChallengeTarget()) {
                        userChallenge.setStatus("GOLD");
                        endChallengeResponseDtoList.add(EndChallengeResponseDto.builder()
                                .challenge(userChallenge.getChallenge())
                                .build());
                    }
                    break;
                case 2:
                    userChallenge.setUserChallengeValue(runningDistance);
                    if (userChallenge.getUserChallengeValue() >= userChallenge.getChallenge().getChallengeTarget()) {
                        userChallenge.setStatus("GOLD");
                        endChallengeResponseDtoList.add(EndChallengeResponseDto.builder()
                                .challenge(userChallenge.getChallenge())
                                .build());
                    }
                    break;
                case 3:
                    List<Date> dateList = runningRepository.findCreateDateByUserId(user);
                    int target = userChallenge.getChallenge().getChallengeTarget();
                    int value = 1;
                    LocalDate checkDate = null;
                    for (Date date :
                            dateList) {
                        if (checkDate == null) {
                            checkDate = date.toLocalDate();
                            continue;
                        }
                        if (checkDate.equals(date.toLocalDate())) continue;
                        if (checkDate.equals(date.toLocalDate().plusDays(1)))
                            value++;
                        else
                            value = 1;
                        if (value >= target) break;
                        checkDate = date.toLocalDate();
                    }
                    if (value != 1)
                        userChallenge.setUserChallengeValue(value);
                    if (userChallenge.getUserChallengeValue() >= target) {
                        userChallenge.setStatus("GOLD");
                        endChallengeResponseDtoList.add(EndChallengeResponseDto.builder()
                                .challenge(userChallenge.getChallenge())
                                .build());
                    }
                    break;
                case 4:
                    userChallenge.setUserChallengeValue(runningRepository.getAccumulatedRunningDays(user).size());
                    if (userChallenge.getUserChallengeValue() >= userChallenge.getChallenge().getChallengeTarget()) {
                        userChallenge.setStatus("GOLD");
                        endChallengeResponseDtoList.add(EndChallengeResponseDto.builder()
                                .challenge(userChallenge.getChallenge())
                                .build());
                    }
                    break;
            }
        }
        EndRunningDto response = EndRunningDto.builder()
                .runningId(savedRunning.getId())
                .endChallengeResponseDtoList(endChallengeResponseDtoList)
                .build();
        userRepository.save(user);
        return response;
    }

    public SumRunningDto getAllRecord(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 유저가 존재하지 않습니다."));

        return runningRepository.findAllRunningHistoryDtoByUserId(user)
                .orElse(new SumRunningDto(0L,0L,0D,0D,new Date(System.currentTimeMillis())));
    }

    public RunningHistoryResponseDto getRecord(int category, Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 유저가 존재하지 않습니다."));
        Calendar calendar1 = Calendar.getInstance();
        Date startDate, endDate;
        Date prevStartDate, prevEndDate;

        if (category == 1) {
            startDate = new Date(calendar1.getTimeInMillis());
            endDate = new Date(calendar1.getTimeInMillis());
            calendar1.add(calendar1.DATE, -1);
            prevStartDate = new Date(calendar1.getTimeInMillis());
            prevEndDate = new Date(calendar1.getTimeInMillis());
        } else if (category == 2) {
            calendar1.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
            startDate = new Date(calendar1.getTimeInMillis());
            calendar1.add(calendar1.DATE, 6);
            endDate = new Date(calendar1.getTimeInMillis());

            calendar1.add(calendar1.DATE, -13);
            prevStartDate = new Date(calendar1.getTimeInMillis());
            calendar1.add(calendar1.DATE, 6);
            prevEndDate = new Date(calendar1.getTimeInMillis());
        } else {
            calendar1.set(calendar1.DATE, 1);
            startDate = new Date(calendar1.getTimeInMillis());
            calendar1.set(calendar1.DATE, calendar1.getActualMaximum(calendar1.DAY_OF_MONTH));
            endDate = new Date(calendar1.getTimeInMillis());
            calendar1.add(calendar1.MONTH, -1);
            calendar1.set(calendar1.DATE, 1);
            prevStartDate = new Date(calendar1.getTimeInMillis());
            calendar1.set(calendar1.DATE, calendar1.getActualMaximum(calendar1.DAY_OF_MONTH));
            prevEndDate = new Date(calendar1.getTimeInMillis());
        }
        RunningRecordDto prevRunningRecordDto = runningRepository.findRunningHistoryDtoByUserId(user, prevStartDate, prevEndDate).get();
        RunningRecordDto curRunningRecordDto = runningRepository.findRunningHistoryDtoByUserId(user, startDate, endDate).get();
        curRunningRecordDto = defaultRunningHistoryDto(curRunningRecordDto);
        prevRunningRecordDto = defaultRunningHistoryDto(prevRunningRecordDto);

        String time1 = convertTime(curRunningRecordDto.getSumRunningTime());
        String time2 = convertTime(curRunningRecordDto.getAvgRunningTime().longValue());
        String time3 = convertTime(prevRunningRecordDto.getAvgRunningTime().longValue());
        /*
        합 :  거리, 칼로리, 시간, 페이스, 조회 기간
        평균 : 과거,현재 /시간, 페이스, 칼로리, 거리/
        Page<Running>
        */
        CurRunningDto curDto = CurRunningDto.builder()
                .avgTime(time2)
                .sumTime(time1)
                .avgDistance(convertDistance(curRunningRecordDto.getAvgRunningDistance()))
                .sumDistance(convertDistance(curRunningRecordDto.getSumRunningDistance()))
                .avgKcal(curRunningRecordDto.getAvgKcal())
                .sumKcal(curRunningRecordDto.getSumKcal())
                .avgPace(convertPace(curRunningRecordDto.getAvgPace()))
                .startDate(startDate.toString())
                .endDate(endDate.toString())
                .originalPace(Math.round(curRunningRecordDto.getAvgPace() * 1000) / 1000.0)
                .originalTime(curRunningRecordDto.getSumRunningTime())
                .build();
        AvgRunningDto prevDto = AvgRunningDto.builder()
                .avgTime(time3)
                .avgDistance(convertDistance(prevRunningRecordDto.getAvgRunningDistance()))
                .avgKcal(prevRunningRecordDto.getAvgKcal())
                .avgPace(convertPace(prevRunningRecordDto.getAvgPace()))
                .originalPace(Math.round(prevRunningRecordDto.getAvgPace() * 1000) / 1000.0)
                .originalTime(prevRunningRecordDto.getSumRunningTime())
                .build();

        return RunningHistoryResponseDto.builder()
                .prevAvg(prevDto)
                .curAvg(curDto)
                .build();
    }

    public Page<RunningEachHistoryDto> getHistory(int category, Long userId, Pageable pageable) {
        Calendar calendar1 = Calendar.getInstance();
        Date startDate, endDate;
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 유저가 존재하지 않습니다."));
        //오늘
        if (category == 1) {
            startDate = new Date(calendar1.getTimeInMillis());
            endDate = new Date(calendar1.getTimeInMillis());
        } else if (category == 2) {
            calendar1.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
            startDate = new Date(calendar1.getTimeInMillis());
            endDate = new Date(Calendar.getInstance().getTimeInMillis());
        } else if (category == 3) {
            calendar1.set(calendar1.DATE, 1);
            startDate = new Date(calendar1.getTimeInMillis());
            endDate = new Date(Calendar.getInstance().getTimeInMillis());
        } else {
            calendar1.set(0, 1, 1);
            startDate = new Date(calendar1.getTimeInMillis());
            endDate = new Date(Calendar.getInstance().getTimeInMillis());
        }
        return runningRepository.findWithDateByUserId(user, startDate, endDate, pageable);
    }

    /**
     * 달력에서 선택한 날짜 API
     *
     * @param userId
     * @param createDate
     * @return CurRunningDto
     */
    public CurRunningDto getIntervalRecord(Long userId, Date createDate) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 유저가 존재하지 않습니다."));
        RunningRecordDto curRunningRecordDto = runningRepository.findRunningRecordDtoByUserId(user, createDate).get();
        curRunningRecordDto = defaultRunningHistoryDto(curRunningRecordDto);

        String time1 = convertTime(curRunningRecordDto.getSumRunningTime());
        String time2 = convertTime(curRunningRecordDto.getAvgRunningTime().longValue());

        return CurRunningDto.builder()
                .avgTime(time2)
                .sumTime(time1)
                .avgDistance(convertDistance(curRunningRecordDto.getAvgRunningDistance()))
                .sumDistance(convertDistance(curRunningRecordDto.getSumRunningDistance()))
                .avgKcal(curRunningRecordDto.getAvgKcal())
                .sumKcal(curRunningRecordDto.getSumKcal())
                .avgPace(convertPace(curRunningRecordDto.getAvgPace()))
                .startDate(createDate.toString())
                .endDate(createDate.toString())
                .originalPace(Math.round(curRunningRecordDto.getAvgPace() * 1000) / 1000.0)
                .originalTime(curRunningRecordDto.getSumRunningTime())
                .build();
    }

    /**
     * 달력에서 선택한 날짜 API
     *
     * @param userId
     * @param createDate
     * @return Page<RunningEachHistoryDto>
     */
    public Page<RunningEachHistoryDto> getIntervalHistory(Long userId, Date createDate, Pageable pageable) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 유저가 존재하지 않습니다."));
        return runningRepository.findByCreateDateAndUserId(user, createDate, pageable);
    }

    private RunningRecordDto defaultRunningHistoryDto(RunningRecordDto runningRecordDto) {
        if (runningRecordDto.getAvgRunningTime() == null) {
            return RunningRecordDto.builder()
                    .avgRunningDistance(0D)
                    .sumRunningDistance(0D)
                    .sumPace(0D)
                    .avgPace(0D)
                    .sumRunningTime(0L)
                    .avgRunningTime(0D)
                    .avgKcal(0D)
                    .sumKcal(0L)
                    .build();
        }
        return runningRecordDto;
    }

    private Double convertDistance(Double distance) {
        return Math.round(distance * 1000) / 1000.0;
    }

    private String convertTime(Long time) {
        String hour = Long.toString(time / 3600);
        time %= 3600;
        String minute = Long.toString(time / 60);
        String second = Long.toString(time % 60);
        if (hour.length() == 1) hour = "0" + hour;
        if (minute.length() == 1) minute = "0" + minute;
        if (second.length() == 1) second = "0" + second;


        return hour + ":" + minute + ":" + second;
    }

    private String convertPace(Double pace) {
        String minute = Integer.toString(pace.intValue() / 60);
        String second = Integer.toString(pace.intValue() % 60);
        return minute + "'" + second + "''";
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
        Challenge challenge = userChallengeRepository.findTop1ByUserIdAndStatusNotAndWithChallenge(userId, "SILVER");
        if (challenge == null) return null;
        ChallengeResponseDto response = new ChallengeResponseDto(challenge);
        return response;
    }
}

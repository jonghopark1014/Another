package com.example.another_back.repository;

import com.example.another_back.dto.RunningEachHistoryDto;
import com.example.another_back.dto.RunningRecordDto;
import com.example.another_back.dto.SumRunningDto;
import com.example.another_back.entity.Running;
import com.example.another_back.entity.User;
import com.example.another_back.entity.enums.Status;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

public interface RunningRepository extends JpaRepository<Running, String> {
    @Query("select distinct r,fp from Running r left outer join fetch r.feedPic fp where r.status = :status order by r.checkDate")
    List<Running> findRunningByStatusWithFeedPics(Status status);

    @Query("select distinct r,fp from Running r left outer join fetch r.feedPic fp where r.user.id = :userId and r.status = :status order by r.checkDate")
    List<Running> findRunningByUserIdAndStatusWithFeedPics(Long userId, Status status);

    @Query("select distinct r,fp from Running r left outer join fetch r.feedPic fp where r.id = :runningId")
    Optional<Running> findRunningByIdWithFeedPics(String runningId);

    List<Running> findByUserIdOrderByCreateDateDesc(Long userId);

    @Query(value = "select new com.example.another_back.dto.RunningEachHistoryDto(r.id, r.runningTime, r.runningDistance,r.userPace, r.createDate, r.userCalories) from Running r where r.user = :user and r.createDate = :createDate")
    Page<RunningEachHistoryDto> findByCreateDateAndUserId(User user, Date createDate, Pageable pageable);

    @Query(value = "select new com.example.another_back.dto.RunningRecordDto(avg(r.runningTime), avg(r.runningDistance), avg(r.userPace), avg(r.userCalories),sum(r.runningTime), sum(r.runningDistance), sum(r.userPace), sum(r.userCalories)) from Running r where r.user = :user and r.createDate = :createDate")
    Optional<RunningRecordDto> findRunningRecordDtoByUserId(User user, Date createDate);

    @Query(value = "select new com.example.another_back.dto.RunningEachHistoryDto(r.id, r.runningTime, r.runningDistance,r.userPace, r.createDate, r.userCalories) from Running r where r.user = :user and r.createDate between :date1 and :date2")
    List<RunningEachHistoryDto> findWithDateByUserId(User user, Date date1, Date date2);

    @Query(value = "select new com.example.another_back.dto.RunningRecordDto(avg(r.runningTime), avg(r.runningDistance), avg(r.userPace), avg(r.userCalories),sum(r.runningTime), sum(r.runningDistance), sum(r.userPace), sum(r.userCalories)) from Running r where r.user = :user and r.createDate between :date1 and :date2 order by r.checkDate")
    Optional<RunningRecordDto> findRunningHistoryDtoByUserId(User user, Date date1, Date date2);

    @Query(value = "select new com.example.another_back.dto.SumRunningDto(sum(r.runningTime), sum(r.userCalories), sum(r.runningDistance), avg(r.userPace), min(r.createDate)) from Running r where r.user = :user")
    Optional<SumRunningDto> findAllRunningHistoryDtoByUserId(User user);

    @Query("select coalesce(sum(r.runningDistance), 0) from Running r where r.user.id = :userId AND r.createDate between :startDate and :endDate")
    Optional<Float> SumRunningDistanceByUserIdAndCreateDateBetween(Long userId, Date startDate, Date endDate);

    @Query("select coalesce(sum(r.runningDistance), 0) from Running r where r.user.id = :userId")
    Optional<Double> SumRunningDistanceByUserId(Long userId);

    @Query("select coalesce(sum(r.runningTime), 0) from Running r where r.user.id = :userId")
    Optional<Long> SumRunningTimeByUserId(Long userId);

    @Query("select r.createDate from Running r where r.user = :user order by r.createDate desc")
    List<Date> findCreateDateByUserId(User user);

    @Query("select count (*) from Running r where r.user = :user group by r.createDate")
    List<Integer> getAccumulatedRunningDays(User user);

    List<Running> findByRunningDistanceBetweenAndRunningTimeBetweenAndUserIdNot(Float startDistance, Float endDistance, String startTime, String endTime, Long userId);
}

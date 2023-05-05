package com.example.another_back.repository;

import com.example.another_back.dto.RunningEachHistoryDto;
import com.example.another_back.dto.RunningHistoryDto;
import com.example.another_back.entity.Running;
import com.example.another_back.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

public interface RunningRepository extends JpaRepository<Running, String> {
    @Query("select distinct r,fp from Running r left outer join fetch r.feedPic fp")
    List<Running> findRunningWithFeedPics();

    @Query("select distinct r,fp from Running r left outer join fetch r.feedPic fp where r.user.id = :userId")
    List<Running> findRunningByUserIdWithFeedPics(Long userId);

    @Query("select distinct r,fp from Running r left outer join fetch r.feedPic fp where r.id = :runningId")
    Optional<Running> findRunningByIdWithFeedPics(String runningId);

    List<Running> findByUserId(Long userId);

    @Query(value = "select new com.example.another_back.dto.RunningEachHistoryDto(r.runningTime, r.runningDistance, r.createDate, r.walkCount, r.kcal) from Running r where r.user = :user and r.createDate between :date1 and :date2")
    Page<RunningEachHistoryDto> findWithDateByUserId(User user, Date date1, Date date2, Pageable pageable);

    @Query(value = "select new com.example.another_back.dto.RunningHistoryDto(sum(r.runningTime), sum(r.runningDistance), count(distinct r.createDate), sum(r.walkCount), sum(r.kcal)) from Running r where r.user = :user and r.createDate between :date1 and :date2 group by r.createDate")
    Optional<RunningHistoryDto> findRunningHistoryDtoByUserId(User user, Date date1, Date date2);

    List<Running> findByRunningDistanceBetweenAndRunningTimeBetweenAndUserIdNot(Float startDistance, Float endDistance, String startTime, String endTime, Long userId);

    @Query("select coalesce(sum(r.runningDistance), 0) from Running r where r.user.id = :userId AND r.createDate between :startDate and :endDate")
    Optional<Float> SumRunningDistanceByUserIdAndCreateDateBetween(Long userId, Date startDate, Date endDate);
}

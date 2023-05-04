package com.example.another_back.repository;

import com.example.another_back.entity.Running;
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

    List<Running> findByRunningDistanceBetweenAndRunningTimeBetweenAndUserIdNot(Float startDistance, Float endDistance, String startTime, String endTime, Long userId);

    @Query("select coalesce(sum(r.runningDistance), 0) from Running r where r.user.id = :userId AND r.createDate between :startDate and :endDate")
    Optional<Float> SumRunningDistanceByUserIdAndCreateDateBetween(Long userId, Date startDate, Date endDate);
}

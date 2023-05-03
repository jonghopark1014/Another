package com.example.another_back.repository;

import com.example.another_back.entity.Running;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface RunningRepository extends JpaRepository<Running, String> {
    @Query("select distinct r,fp from Running r left outer join fetch r.feedPic fp")
    List<Running> findRunningWithFeedPics();

    List<Running> findByUserId(Long userId);
}

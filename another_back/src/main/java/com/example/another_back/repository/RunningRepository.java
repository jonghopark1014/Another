package com.example.another_back.repository;

import com.example.another_back.entity.Running;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface RunningRepository extends JpaRepository<Running, String> {
    @Query("select distinct r,fp from Running r left outer join fetch r.feedPic fp")
    List<Running> findAll();
    Optional<Running> findById(String runningId);
}

package com.example.another_back.repository;

import com.example.another_back.entity.Running;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RunningRepository extends JpaRepository<Running, String> {

    Optional<Running> findById(String runningId);
}

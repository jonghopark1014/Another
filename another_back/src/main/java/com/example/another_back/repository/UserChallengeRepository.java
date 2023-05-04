package com.example.another_back.repository;

import com.example.another_back.entity.UserChallenge;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserChallengeRepository extends JpaRepository<UserChallenge, Long>, CustormUserChallengeRepository {
}

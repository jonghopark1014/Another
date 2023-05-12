package com.example.another_back.repository;

import com.example.another_back.entity.User;
import com.example.another_back.entity.UserChallenge;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserChallengeRepository extends JpaRepository<UserChallenge, Long>, CustormUserChallengeRepository {
    List<UserChallenge> findByUser(User user);
}

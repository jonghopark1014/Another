package com.example.another_back.repository;

import com.example.another_back.entity.Challenge;

import java.util.Optional;

public interface CustormUserChallengeRepository {
    Challenge findTop1ByUserAndStatusNotaAndWithChallenge(Long userId, String status);
}

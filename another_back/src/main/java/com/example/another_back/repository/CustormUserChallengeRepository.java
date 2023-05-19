package com.example.another_back.repository;

import com.example.another_back.entity.Challenge;

public interface CustormUserChallengeRepository {
    Challenge findTop1ByUserIdAndStatusNotAndWithChallenge(Long userId, String status);
}

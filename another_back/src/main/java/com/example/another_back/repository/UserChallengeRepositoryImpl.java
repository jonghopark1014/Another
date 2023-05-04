package com.example.another_back.repository;

import com.example.another_back.entity.Challenge;
import lombok.RequiredArgsConstructor;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

@RequiredArgsConstructor
public class UserChallengeRepositoryImpl implements CustormUserChallengeRepository {
    private final EntityManager em;

    @Override
    public Challenge findTop1ByUserAndStatusNotaAndWithChallenge(Long userId, String status) {
        try {
            return em.createQuery("select uc.challenge from UserChallenge uc where uc.user.id = :userId and uc.Status = :status", Challenge.class)
                    .setParameter("userId", userId)
                    .setParameter("status", status)
                    .setMaxResults(1)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}

import 'package:flutter/material.dart';
import './category_title.dart';
import './challenge_item.dart';
import '../challenge.dart';

class MonthChallenge extends StatelessWidget {
  final List<dynamic> challengeData;
  final double? Function(List<dynamic>, String) getChallengeValue;

  const MonthChallenge({Key? key, required this.challengeData, required this.getChallengeValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          CategoryTitle(title: '월간 시간 챌린지'),
          Spacer(), // 다른 자식 위젯들을 오른쪽으로 밀어내기 위해 추가
        ]),
        Wrap(
          direction: Axis.horizontal,
          spacing: 20,
          runSpacing: 20,
          children: [
            ChallengeItem(
              title: '이번 달 300분 런닝뛰기',
              progress: getChallengeValue(challengeData, '300분 달성'),
              goldBadge: '300min_gold.png',
              silverBadge: '300min_gold.png',
              // goldBadge: challenge['goldBadge'],
              // silverBadge: challenge['silverBadge'],
            ),
            ChallengeItem(
              title: '이번 달 600분 런닝뛰기',
              progress: getChallengeValue(challengeData, '600분 달성'),
              goldBadge: '300min_gold.png',
              silverBadge: '300min_gold.png',
              // goldBadge: challenge['goldBadge'],
              // silverBadge: challenge['silverBadge'],
            ),
            ChallengeItem(
              title: '이번 달 900분 런닝뛰기',
              progress: getChallengeValue(challengeData, '900분 달성'),
              goldBadge: '300min_gold.png',
              silverBadge: '300min_gold.png',
              // goldBadge: challenge['goldBadge'],
              // silverBadge: challenge['silverBadge'],
            ),
            ChallengeItem(
              title: '이번 달 1200분 런닝뛰기',
              progress: getChallengeValue(challengeData, '1200분 달성'),
              goldBadge: '300min_gold.png',
              silverBadge: '300min_gold.png',
              // goldBadge: challenge['goldBadge'],
              // silverBadge: challenge['silverBadge'],
            ),
            ChallengeItem(
              title: '이번 달 1500분 런닝뛰기',
              progress: getChallengeValue(challengeData, '1500분 달성'),
              goldBadge: '300min_gold.png',
              silverBadge: '300min_gold.png',
              // goldBadge: challenge['goldBadge'],
              // silverBadge: challenge['silverBadge'],
            ),
          ]
        ),
      ],
    );
  }
}


class CampusChallenge extends StatelessWidget {
  final List<dynamic> challengeData;
  final double? Function(List<dynamic>, String) getChallengeValue;

  const CampusChallenge({Key? key, required this.challengeData, required this.getChallengeValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          CategoryTitle(title: '캠퍼스 완주 챌린지'),
          Spacer(), // 다른 자식 위젯들을 오른쪽으로 밀어내기 위해 추가
        ]),
        Wrap(
            direction: Axis.horizontal,
            spacing: 20,
            runSpacing: 20,
            children: [
              ChallengeItem(
                title: '서울에서 대전까지',
                progress: getChallengeValue(challengeData, '서울에서 대전까지'),
                goldBadge: '300min_gold.png',
                silverBadge: '300min_gold.png',
                // goldBadge: challenge['goldBadge'],
                // silverBadge: challenge['silverBadge'],
              ),
              ChallengeItem(
                title: '서울에서 구미까지',
                progress: getChallengeValue(challengeData, '서울에서 구미까지'),
                goldBadge: '300min_gold.png',
                silverBadge: '300min_gold.png',
                // goldBadge: challenge['goldBadge'],
                // silverBadge: challenge['silverBadge'],
              ),
              ChallengeItem(
                title: '서울에서 광주까지',
                progress: getChallengeValue(challengeData, '서울에서 광주까지'),
                goldBadge: '300min_gold.png',
                silverBadge: '300min_gold.png',
                // goldBadge: challenge['goldBadge'],
                // silverBadge: challenge['silverBadge'],
              ),
              ChallengeItem(
                title: '서울에서 부울경까지',
                progress: getChallengeValue(challengeData, '서울에서 부울경까지'),
                goldBadge: '300min_gold.png',
                silverBadge: '300min_gold.png',
                // goldBadge: challenge['goldBadge'],
                // silverBadge: challenge['silverBadge'],
              ),
              ChallengeItem(
                title: '전체 캠퍼스 완주',
                progress: getChallengeValue(challengeData, '전체 캠퍼스 완주'),
                goldBadge: '300min_gold.png',
                silverBadge: '300min_gold.png',
                // goldBadge: challenge['goldBadge'],
                // silverBadge: challenge['silverBadge'],
              ),
              ChallengeItem(
                title: '🌏 누적 지구 한바퀴 🌏',
                progress: getChallengeValue(challengeData, '누적 지구 한바퀴'),
                goldBadge: '300min_gold.png',
                silverBadge: '300min_gold.png',
                // goldBadge: challenge['goldBadge'],
                // silverBadge: challenge['silverBadge'],
              ),
            ]
        ),
      ],
    );
  }
}


class SteadyChallenge extends StatelessWidget {
  final List<dynamic> challengeData;
  final double? Function(List<dynamic>, String) getChallengeValue;

  const SteadyChallenge({Key? key, required this.challengeData, required this.getChallengeValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          CategoryTitle(title: '연속 출석 챌린지'),
          Spacer(), // 다른 자식 위젯들을 오른쪽으로 밀어내기 위해 추가
        ]),
        Wrap(
            direction: Axis.horizontal,
            spacing: 20,
            runSpacing: 20,
            children: [
              ChallengeItem(
                title: '연속 3일 출석 달성',
                progress: getChallengeValue(challengeData, '연속 3일 출석 달성'),
                goldBadge: '300min_gold.png',
                silverBadge: '300min_gold.png',
                // goldBadge: challenge['goldBadge'],
                // silverBadge: challenge['silverBadge'],
              ),
              ChallengeItem(
                title: '누적 600분 달성',
                progress: getChallengeValue(challengeData, '연속 5일 출석 달성'),
                goldBadge: '300min_gold.png',
                silverBadge: '300min_gold.png',
                // goldBadge: challenge['goldBadge'],
                // silverBadge: challenge['silverBadge'],
              ),
              ChallengeItem(
                title: '누적 900분 달성',
                progress: getChallengeValue(challengeData, '연속 10일 출석 달성'),
                goldBadge: '300min_gold.png',
                silverBadge: '300min_gold.png',
                // goldBadge: challenge['goldBadge'],
                // silverBadge: challenge['silverBadge'],
              ),
            ]
        ),
      ],
    );
  }
}

class TotalDayChallenge extends StatelessWidget {
  final List<dynamic> challengeData;
  final double? Function(List<dynamic>, String) getChallengeValue;

  const TotalDayChallenge(
      {Key? key, required this.challengeData, required this.getChallengeValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          CategoryTitle(title: '누적 출석 챌린지'),
          Spacer(), // 다른 자식 위젯들을 오른쪽으로 밀어내기 위해 추가
        ]),
        Wrap(
            direction: Axis.horizontal,
            spacing: 20,
            runSpacing: 20,
            children: [
              ChallengeItem(
                title: '누적 30일 출석 달성',
                progress: getChallengeValue(challengeData, '누적 30일 출석 달성'),
                goldBadge: '300min_gold.png',
                silverBadge: '300min_gold.png',
                // goldBadge: challenge['goldBadge'],
                // silverBadge: challenge['silverBadge'],
              ),
              ChallengeItem(
                title: '누적 100일 출석 달성',
                progress: getChallengeValue(challengeData, '누적 100일 출석 달성'),
                goldBadge: '300min_gold.png',
                silverBadge: '300min_gold.png',
                // goldBadge: challenge['goldBadge'],
                // silverBadge: challenge['silverBadge'],
              ),
              ChallengeItem(
                title: '누적 365일 출석 달성',
                progress: getChallengeValue(challengeData, '누적 365일 출석 달성'),
                goldBadge: '300min_gold.png',
                silverBadge: '300min_gold.png',
                // goldBadge: challenge['goldBadge'],
                // silverBadge: challenge['silverBadge'],
              ),
            ]
        ),
      ],
    );
  }
}
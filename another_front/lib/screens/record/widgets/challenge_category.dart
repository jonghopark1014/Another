import 'package:flutter/material.dart';
import './category_title.dart';
import './challenge_item.dart';
import '../challenge.dart';

class MonthChallenge extends StatelessWidget {
  final List<dynamic> challengeData;
  final double? Function(List<dynamic>, String) getChallengeValue;

  const MonthChallenge(
      {Key? key, required this.challengeData, required this.getChallengeValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          CategoryTitle(title: '월간 시간 챌린지', top: 25, bottom: 10),
          Spacer(), // 다른 자식 위젯들을 오른쪽으로 밀어내기 위해 추가
        ]),
        Wrap(
            direction: Axis.horizontal,
            spacing: 20,
            runSpacing: 20,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ChallengeItem(
                  title: '이번 달 300분 런닝뛰기',
                  progress: getChallengeValue(challengeData, '300분 달성'),
                  goldBadge: 'gold_300min.png',
                  silverBadge: '은메달_300분.png',
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ChallengeItem(
                  title: '이번 달 600분 런닝뛰기',
                  progress: getChallengeValue(challengeData, '600분 달성'),
                  goldBadge: 'gold_600min.png',
                  silverBadge: '은메달_600분.png',
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ChallengeItem(
                  title: '이번 달 900분 런닝뛰기',
                  progress: getChallengeValue(challengeData, '900분 달성'),
                  goldBadge: 'gold_900min.png',
                  silverBadge: '은메달_900분.png',
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ChallengeItem(
                  title: '이번 달 1200분 런닝뛰기',
                  progress: getChallengeValue(challengeData, '1200분 달성'),
                  goldBadge: 'gold_1200min.png',
                  silverBadge: '은메달_1200분.png',
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ChallengeItem(
                  title: '이번 달 1500분 런닝뛰기',
                  progress: getChallengeValue(challengeData, '1500분 달성'),
                  goldBadge: 'gold_1500min.png',
                  silverBadge: '은메달_1500분.png',
                ),
              ),
            ]),
      ],
    );
  }
}

class CampusChallenge extends StatelessWidget {
  final List<dynamic> challengeData;
  final double? Function(List<dynamic>, String) getChallengeValue;

  const CampusChallenge(
      {Key? key, required this.challengeData, required this.getChallengeValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          CategoryTitle(title: '캠퍼스 완주 챌린지', top: 25, bottom: 10),
          Spacer(), // 다른 자식 위젯들을 오른쪽으로 밀어내기 위해 추가
        ]),
        Wrap(
            direction: Axis.horizontal,
            spacing: 20,
            runSpacing: 20,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ChallengeItem(
                  title: '서울에서 대전까지',
                  progress: getChallengeValue(challengeData, '서울에서 대전까지'),
                  goldBadge: 'gold_seoul_to_daejeon.png',
                  silverBadge: '은메달_서울대전.png',
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ChallengeItem(
                  title: '서울에서 구미까지',
                  progress: getChallengeValue(challengeData, '서울에서 구미까지'),
                  goldBadge: 'gold_seoul_to_gumi.png',
                  silverBadge: '은메달_서울구미.png',
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ChallengeItem(
                  title: '서울에서 광주까지',
                  progress: getChallengeValue(challengeData, '서울에서 광주까지'),
                  goldBadge: 'gold_seoul_to_gwangju.png',
                  silverBadge: '은메달_서울광주.png',
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ChallengeItem(
                  title: '서울에서 부울경까지',
                  progress: getChallengeValue(challengeData, '서울에서 부울경까지'),
                  goldBadge: 'gold_seoul_to_busan.png',
                  silverBadge: '은메달_서울부울경.png',
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ChallengeItem(
                  title: '전체 캠퍼스 완주',
                  progress: getChallengeValue(challengeData, '전체 캠퍼스 완주'),
                  goldBadge: 'gold_all_campus.png',
                  silverBadge: '은메달_전체캠퍼스.png',
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ChallengeItem(
                  title: '🌏 누적 지구 한바퀴 🌏',
                  progress: getChallengeValue(challengeData, '누적 지구 한바퀴'),
                  goldBadge: '금메달_지구한바퀴.png',
                  silverBadge: '은메달_누적지구.png',
                  // goldBadge: challenge['goldBadge'],
                  // silverBadge: challenge['silverBadge'],
                ),
              ),
            ]),
      ],
    );
  }
}

class SteadyChallenge extends StatelessWidget {
  final List<dynamic> challengeData;
  final double? Function(List<dynamic>, String) getChallengeValue;

  const SteadyChallenge(
      {Key? key, required this.challengeData, required this.getChallengeValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          CategoryTitle(title: '연속 출석 챌린지', top: 25, bottom: 10),
          Spacer(), // 다른 자식 위젯들을 오른쪽으로 밀어내기 위해 추가
        ]),
        Wrap(
          direction: Axis.horizontal,
          spacing: 20,
          runSpacing: 20,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ChallengeItem(
                title: '첫번째 러닝 뛰기',
                progress: getChallengeValue(challengeData, '첫번째 러닝 달성'),
                goldBadge: 'gold_firstrun.png',
                silverBadge: '은메달_첫번째러닝.png',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ChallengeItem(
                title: '연속 3일 출석 달성',
                progress: getChallengeValue(challengeData, '연속 3일 출석 달성'),
                goldBadge: 'gold_cont_3day.png',
                silverBadge: '은메달_연속3일.png',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ChallengeItem(
                title: '연속 5일 출석 달성',
                progress: getChallengeValue(challengeData, '연속 5일 출석 달성'),
                goldBadge: 'gold_cont_5day.png',
                silverBadge: '은메달_연속5일.png',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ChallengeItem(
                title: '연속 10일 출석 달성',
                progress: getChallengeValue(challengeData, '연속 10일 출석 달성'),
                goldBadge: 'gold_cont_10day.png',
                silverBadge: '은메달_연속10일.png',
              ),
            ),
          ],
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
          CategoryTitle(title: '누적 출석 챌린지', top: 25, bottom: 10),
          Spacer(), // 다른 자식 위젯들을 오른쪽으로 밀어내기 위해 추가
        ]),
        Wrap(
          direction: Axis.horizontal,
          spacing: 20,
          runSpacing: 20,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ChallengeItem(
                title: '누적 30일 출석 달성',
                progress: getChallengeValue(challengeData, '누적 30일 출석 달성'),
                goldBadge: 'gold_accu_30day.png',
                silverBadge: '은메달_누적30일.png',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ChallengeItem(
                title: '누적 100일 출석 달성',
                progress: getChallengeValue(challengeData, '누적 100일 출석 달성'),
                goldBadge: 'gold_accu_100day.png',
                silverBadge: '은메달_누적100일.png',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ChallengeItem(
                title: '누적 365일 출석 달성',
                progress: getChallengeValue(challengeData, '누적 365일 출석 달성'),
                goldBadge: 'gold_accu_365day.png',
                silverBadge: '은메달_누적365일.png',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:another/widgets/go_back_appbar_style.dart';
import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';
import './widgets/category_title.dart';
import './widgets/challenge_item.dart';

class ChallengePage extends StatelessWidget {
  ChallengePage({Key? key}) : super(key: key);

  var monthChallenges = [
    {
      'title': '300분 달성',
      'progress': 0.2,
      'goldBadge': '300min_gold.png',
      'silverBadge': '300min_silver.png',
    },
    {
      'title': '30분 달성',
      'progress': 0.5,
      'goldBadge': '300min_gold.png',
      'silverBadge': '300min_silver.png',
    },
    {
      'title': '300분 달성',
      'progress': 1.2,
      'goldBadge': '300min_gold.png',
      'silverBadge': '300min_silver.png',
    },
  ];
  var campusChallenges = [
    {
      'title': '300분 달성',
      'progress': 1.2,
      'goldBadge': '300min_gold.png',
      'silverBadge': '300min_silver.png',
    },
    {
      'title': '30분 달성',
      'progress': 1.0,
      'goldBadge': '300min_gold.png',
      'silverBadge': '300min_silver.png',
    },
    {
      'title': '30분 달성',
      'progress': 0.8,
      'goldBadge': '300min_gold.png',
      'silverBadge': '300min_silver.png',
    },
    {
      'title': '300분 달성',
      'progress': 1.2,
      'goldBadge': '300min_gold.png',
      'silverBadge': '300min_silver.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBarStyle(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              ChallengeHeader(exp: 12000),
              // 월간 시간 챌린지
              Row(
                children: [
                  CategoryTitle(title: '월간 시간 챌린지'),
                  Spacer(), // 다른 자식 위젯들을 오른쪽으로 밀어내기 위해 추가
                ]
              ),
              GridView.count(
                crossAxisCount: 2, //한 행에 두 개의 아이템 배치
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 0.8,
                shrinkWrap: true,
                children: List.generate(
                  monthChallenges.length,
                      (index) {
                    final challenge = monthChallenges[index];
                    return ChallengeItem(
                        title: challenge['title'],
                        progress: challenge['progress'],
                        goldBadge: challenge['goldBadge'],
                        silverBadge: challenge['silverBadge']
                    );
                  },
                ),
              ),
              // 캠퍼스 챌린지
              Row(
                  children: [
                    CategoryTitle(title: '캠퍼스 챌린지'),
                    Spacer(), // 다른 자식 위젯들을 오른쪽으로 밀어내기 위해 추가
                  ]
              ),
              GridView.count(
                crossAxisCount: 2, //한 행에 두 개의 아이템 배치
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 0.8,
                shrinkWrap: true,
                children: List.generate(
                  campusChallenges.length,
                      (index) {
                    final challenge = campusChallenges[index];
                    return ChallengeItem(
                        title: challenge['title'],
                        progress: challenge['progress'],
                        goldBadge: challenge['goldBadge'],
                        silverBadge: challenge['silverBadge']
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class ChallengeHeader extends StatelessWidget {
  final int exp; // 경험치를 담을 동적인 변수
  ChallengeHeader({Key? key, required this.exp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            'MY 챌린지 🏆',
            style: TextStyle(
              color: SERVEONE_COLOR,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
          decoration: BoxDecoration(
            color: SERVETHREE_COLOR,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MAIN_COLOR, // 테두리의 색상 설정
                    width: 2, // 테두리의 두께 설정
                  ),
                ),
                child: Center(
                  child: Text(
                    'E',
                    style: TextStyle(
                      color: MAIN_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Circle과 "나의 경험치" 사이에 간격 추가
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '나의 경험치',
                      style: TextStyle(
                        color: MAIN_COLOR,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$exp EXP', // "$exp EXP"로 표시
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
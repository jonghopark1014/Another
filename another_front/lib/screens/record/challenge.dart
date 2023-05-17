import 'package:another/constant/const/color.dart';
import 'package:another/screens/record/widgets/challenge_category.dart';
import 'package:another/widgets/go_back_appbar_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './widgets/category_title.dart';
import './widgets/challenge_item.dart';
import './api/challenge_api.dart';
import 'package:provider/provider.dart';
import 'package:another/main.dart';

class ChallengePage extends StatefulWidget {
  ChallengePage({Key? key}) : super(key: key);

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  List<dynamic> _challengeData = [];
  bool _isLoading = true; // 데이터를 받아오는 중
  int totalUserExp = 0;

  @override
  void initState() {
    super.initState();
    getChallenge();
    totalUserExp = userExp();
  }

  int userExp() {
    var provider = Provider.of<UserInfo>(context, listen: false);
    int userLevel = provider.userLevel;
    double userExp = provider.userExp;
    int totalUserExp;
    switch (userLevel) {
      case 1:
        totalUserExp = (userExp * 10).round();
        break;
      case 2:
        totalUserExp = (10 + userExp * 50).round();
        break;
      case 3:
        totalUserExp = (50 + userExp * 100).round();
        break;
      case 4:
        totalUserExp = (100 + userExp * 500).round();
        break;
      case 5:
        totalUserExp = (500 + userExp * 1000).round();
        break;
      case 6:
        totalUserExp = (1000 + userExp * 5000).round();
        break;
      case 7:
        totalUserExp = (5000 + userExp * 10000).round();
        break;
      case 8:
        totalUserExp = (10000 + userExp * 50000).round();
        break;
      case 9:
        totalUserExp = (50000 + userExp * 100000).round();
        break;
      case 10:
        totalUserExp = 166660;
      default:
        totalUserExp = 0;
    }
    return totalUserExp;
  }

  Future<void> getChallenge() async {
    int userId = Provider.of<UserInfo>(context, listen: false).userId;
    List<dynamic> data = await GetChallenge.challengeList(userId);
    setState(() {
      _challengeData = data;
      _isLoading = false;
    });
  }

  double? getChallengeValue(List<dynamic> challengeData, String challengeName) {
    final challenge = challengeData.firstWhere(
      (data) {
        return data['challengeName'] == challengeName;
      },
      orElse: () => null,
    );
    if (challenge != null) {
      if (challenge['challengeValue'] is int) {
        return (challenge['challengeValue'] as int).toDouble();
      } else {
        return challenge['challengeValue'] as double?;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int userExp = (Provider.of<UserInfo>(context).userExp).toInt();
    print(userExp);
    return Scaffold(
        appBar: GoBackAppBarStyle(),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ChallengeHeader(exp: totalUserExp),
                      // 월간 시간 챌린지
                      MonthChallenge(
                          challengeData: _challengeData,
                          getChallengeValue: getChallengeValue),
                      // 캠퍼스 챌린지
                      CampusChallenge(
                          challengeData: _challengeData,
                          getChallengeValue: getChallengeValue),
                      // 꾸준함 챌린지
                      SteadyChallenge(
                          challengeData: _challengeData,
                          getChallengeValue: getChallengeValue),
                      // 누적 챌린지
                      TotalDayChallenge(
                          challengeData: _challengeData,
                          getChallengeValue: getChallengeValue),
                    ],
                  ),
                ),
              ));
  }
}

class ChallengeHeader extends StatelessWidget {
  final int exp; // 경험치를 담을 동적인 변수
  ChallengeHeader({Key? key, required this.exp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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

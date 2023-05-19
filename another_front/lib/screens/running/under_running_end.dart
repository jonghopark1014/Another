import 'dart:typed_data';

import 'package:another/constant/layout/main_layout.dart';
import 'package:another/screens/running/under_challenge_end_feed.dart';
import 'package:another/screens/running/widgets/button_component.dart';
import 'package:another/screens/running/widgets/running_end.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../home_screen.dart';
import './api/under_running_end_api.dart';

class UnderRunningScreenEnd extends StatelessWidget {
  final String runningDistance;
  final String runningTime;
  final String userCalorie;
  final String userPace;
  UnderRunningScreenEnd({
    required this.runningDistance,
    required this.runningTime,
    required this.userCalorie,
    required this.userPace,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("빌드빌드end빌드예예");
    final Size size = MediaQuery.of(context).size;
    return MainLayout(
      body: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Target(
                      targetname: '내 기록',
                      runningDistance: runningDistance,
                      runningTime: runningTime,
                      userCalorie: userCalorie,
                      userPace: userPace,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: size.height / 11 * 6,
                          ),
                          child: SizedBox(
                            height: size.width,
                            width: size.width,
                            child: EndRunningMap(),
                          ),
                        )
                    ),
                    // SizedBox(
                    //   height: 120,
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ButtonConponent(
                  onPressed: () => endFeed(context),
                  feedComplete: () => feedComplete(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void endFeed(BuildContext context) {
    print("피드 끝낸당");
    var runningData = Provider.of<RunningData>(context, listen: false);
    if (runningData.isCap >= 3) {
      var runningData = Provider.of<RunningData>(context, listen: false);
      var userId = Provider.of<UserInfo>(context, listen: false).userId;
      saveRunningTime.saveRunData(userId: userId!, runningId: runningData.runningId, runningTime: runningData.runningTime, runningDistance: runningData.runningDistance, userCalories: runningData.userCalories, userPace: runningData.userPace, runningPic: runningData.runningPic);
      // // hdfs 저장
      saveRunningTime.sendTopic(runningId: runningData.runningId, userId: userId);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => UnderChallengeScreenEndFeed(captureInfo: Provider.of<RunningData>(context, listen: false).runningPic),
          ), (router) => false);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(duration: Duration(milliseconds: 1000), content: Text('발자취를 담는 중 입니다.')));
    }
  }

  void feedComplete(BuildContext context) {
    var runningData = Provider.of<RunningData>(context, listen: false);
    print("오운완쓰 등록 간다잉");
    if (runningData.isCap >= 3) {
      var runningData = Provider.of<RunningData>(context, listen: false);
      var userId = Provider.of<UserInfo>(context, listen: false).userId;
      saveRunningTime.saveRunData(userId: userId!, runningId: runningData.runningId, runningTime: runningData.runningTime, runningDistance: runningData.runningDistance, userCalories: runningData.userCalories, userPace: runningData.userPace, runningPic: runningData.runningPic);
      // // hdfs 저장
      saveRunningTime.sendTopic(runningId: runningData.runningId, userId: userId);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => HomeScreen(),

        ),
          (router) => false,
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(duration: Duration(milliseconds: 1000), content: Text('발자취를 담는 중 입니다.')));
    }

  }
}

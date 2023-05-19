import 'package:another/main.dart';
import 'package:another/screens/home_screen.dart';
import 'package:another/screens/running/api/under_running_end_api.dart';
import 'package:another/screens/running/under_challenge_end_feed.dart';
import 'package:another/screens/running/widgets/button_component.dart';
import 'package:another/screens/running/widgets/running_end.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../feed/widgets/line_chart_custom.dart';

class UnderChallengeScreenEnd extends StatelessWidget {
  final String runningDistance;
  final String runningTime;
  final String userCalorie;
  final String userPace;

  UnderChallengeScreenEnd({
    required this.runningDistance,
    required this.runningTime,
    required this.userCalorie,
    required this.userPace,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var challengeData = Provider.of<ChallengeData>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Target(
                      targetname: '목표 기록',
                      runningDistance: challengeData.runningDistance,
                      userCalorie: challengeData.userCalorie,
                      runningTime: challengeData.runningTime,
                      userPace: challengeData.userPace,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Target(
                        targetname: '내기록',
                        runningTime: runningTime,
                        userCalorie: userCalorie,
                        runningDistance: runningDistance,
                        userPace: userPace,
                      ),
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
    var runningData = Provider.of<RunningData>(context, listen: false);
    if (runningData.isCap >= 3) {
      var runningData = Provider.of<RunningData>(context, listen: false);
      var userId = Provider.of<UserInfo>(context, listen: false).userId;
      saveRunningTime.saveRunData(userId: userId!, hostRunningId: Provider.of<ChallengeData>(context, listen: false).hostRunningId, runningId: runningData.runningId, runningTime: runningData.runningTime, runningDistance: runningData.runningDistance, userCalories: runningData.userCalories, userPace: runningData.userPace, runningPic: runningData.runningPic);
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
    if (runningData.isCap >= 3) {
      var runningData = Provider.of<RunningData>(context, listen: false);
      var userId = Provider.of<UserInfo>(context, listen: false).userId;
      saveRunningTime.saveRunData(userId: userId!, hostRunningId: Provider.of<ChallengeData>(context, listen: false).hostRunningId, runningId: runningData.runningId, runningTime: runningData.runningTime, runningDistance: runningData.runningDistance, userCalories: runningData.userCalories, userPace: runningData.userPace, runningPic: runningData.runningPic);
      // // hdfs 저장
      saveRunningTime.sendTopic(runningId: runningData.runningId, userId: userId);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ),
          (route) => false,
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(duration: Duration(milliseconds: 1000), content: Text('발자취를 담는 중 입니다.')));
    }
  }
}

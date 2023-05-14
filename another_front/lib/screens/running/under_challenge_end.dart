import 'package:another/main.dart';
import 'package:another/screens/running/under_challenge_end_feed.dart';
import 'package:another/screens/running/widgets/button_component.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../feed/widgets/line_chart_custom.dart';

class UnderChallengeScreenEnd extends StatelessWidget {
  final Uint8List? captureInfo;
  final String runningDistance;
  final String runningTime;
  final String userCalorie;
  final String userPace;

  UnderChallengeScreenEnd({
    required this.captureInfo,
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
                    Image.memory(
                      captureInfo!,
                    )
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
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => UnderChallengeScreenEndFeed(captureInfo: captureInfo),
        ),
        (route) => route.settings.name == '/');
  }

  void feedComplete(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UnderChallengeScreenEndFeed(captureInfo: captureInfo),
      ),
    );
  }
}

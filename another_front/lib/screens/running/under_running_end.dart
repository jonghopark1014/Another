import 'dart:typed_data';

import 'package:another/constant/color.dart';
import 'package:another/constant/main_layout.dart';
import 'package:another/screens/running/under_challenge_end_feed.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/material.dart';

class UnderRunningScreenEnd extends StatelessWidget {
  final Uint8List? captureInfo;
  final String runningDistance;
  final String runningTime;
  final String kcal;
  final String speed;
  UnderRunningScreenEnd({
    required this.captureInfo,
    required this.runningDistance,
    required this.runningTime,
    required this.kcal,
    required this.speed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MainLayout(
      body: Column(
        children: [
          Target(
            targetname: '내 기록',
            runningDistance: runningDistance,
            runningTime: runningTime,
            kcal: kcal,
            speed: speed,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: SizedBox(
              height: 300.0,
              width: size.width,
              child: Image.memory(
                captureInfo!,
                width: 300.0,
              ),
            ),
          ),
          SizedBox(
            height: 120,
          ),
          ButtonConponent(
            onPressed: () => endFeed(context),
          ),
        ],
      ),
    );
  }

  void endFeed(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => UnderChallengeScreenEndFeed(),
        ),
        (route) => route.settings.name == '/');
  }
}

class ButtonConponent extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonConponent({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: size.height * 0.08,
            width: size.width * 0.4,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: SERVETWO_COLOR,
                elevation: 10.0,
              ),
              child: Text(
                '다음에 할래요!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Container(
            height: size.height * 0.08,
            width: size.width * 0.4,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: MAIN_COLOR,
                elevation: 10.0,
              ),
              child: Text(
                '오운완 등록하기',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

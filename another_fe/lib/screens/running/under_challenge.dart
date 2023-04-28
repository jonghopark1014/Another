import 'package:another/constant/color.dart';
import 'package:another/screens/running/under_challenge_end.dart';
import 'package:another/screens/running/widgets/distancebar.dart';
import 'package:flutter/material.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:another/widgets/target.dart';

import '../../widgets/record_result.dart';

class UnderChallenge extends StatefulWidget {
  const UnderChallenge({Key? key}) : super(key: key);

  @override
  State<UnderChallenge> createState() => _UnderChallengeState();
}

class _UnderChallengeState extends State<UnderChallenge> {
  double _currentSliderValue = 0.0;
  bool isStart = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Target(targetname: '목표기록'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      DistanceBar(name:'상대 페이스',),
                      DistanceBar(name:'내 페이스',),
                    ],
                  )),
                RecordResult(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // RunningCircleButton(iconNamed: Icons.play_arrow,onPressed: ,),
                      isStart
                          ? RunningCircleButton(
                              iconNamed: Icons.play_arrow,
                              onPressed: onPause,
                            )
                          : RunningCircleButton(
                              iconNamed: Icons.pause,
                              onPressed: onPause,
                            ),
                      RunningCircleButton(
                        iconNamed: Icons.stop,
                        onPressed: onStop,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPause() {
    isStart = !isStart;
    setState(() {});
  }
  void onStop() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => UnderChallengeScreenEnd(),
            ),
            (route) => false);
      }
}


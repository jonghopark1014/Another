import 'package:another/screens/running/under_challenge_end.dart';
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
  double _currentSliderValue = 40.0;
  bool isStart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Target(targetRecord: '목표기록'),
                Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: 100,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    }),
                Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: 100,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    }),
                RecordResult(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // RunningCircleButton(iconNamed: Icons.play_arrow,onPressed: ,),
                      isStart
                          ? RunningCircleButton(
                              iconNamed: Icons.play_arrow,
                            )
                          : RunningCircleButton(
                              iconNamed: Icons.pause,
                            ),
                      RunningCircleButton(
                        iconNamed: Icons.stop,
                      ),
                      // RunningCircleButton(iconNamed: Icons.play_arrow,onPressed: ,),
                      //RunningCircleButton(iconNamed: Icons.pause, onPressed: ,),
                      //RunningCircleButton(iconNamed: Icons.stop,onPressed: ,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPause() => {
    isStart = true
  };
  void onStop() => {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => UnderChallengeScreenEnd()),
            (route) => false)
      };
}

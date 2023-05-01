import 'package:flutter/material.dart';
import 'dart:async';

import 'package:another/screens/running/under_challenge_end.dart';
import 'package:another/screens/running/widgets/distancebar.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:another/widgets/target.dart';
import '../../widgets/record_result.dart';

class UnderChallenge extends StatefulWidget {
  const UnderChallenge({Key? key}) : super(key: key);

  @override
  State<UnderChallenge> createState() => _UnderChallengeState();
}

class _UnderChallengeState extends State<UnderChallenge> {
  late Timer _timer;

  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  // 여기에다가 변화는 값 만들어 줘야됨
  double _currentSliderValue = 80.0;
  bool isStart = false;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
        if (seconds == 60) {
          minutes += 1;
          seconds = 0;
        } else if (minutes == 60) {
          hours += 1;
          minutes = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
                  child: Stack(children: [
                    Column(
                      children: [
                        DistanceBar(
                          name: '상대 페이스',
                          pace: _currentSliderValue,
                        ),
                        DistanceBar(
                          name: '내 페이스',
                          pace: _currentSliderValue,
                        ),
                      ],
                    ),
                    Positioned(
                      child: AbsorbPointer(
                        absorbing: true,
                        child: Container(
                          width: 400,
                          height: 150,
                        ),
                      ),
                    ),
                  ]),
                ),
                RecordResult(
                  timer:
                  '${hours.toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}',
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // RunningCircleButton(iconNamed: Icons.play_arrow,onPressed: ,),
                      isStart
                          ? RunningCircleButton(
                        iconNamed: Icons.play_arrow,
                        onPressed: onStart,
                      )
                          : RunningCircleButton(
                        iconNamed: Icons.pause,
                        onPressed: onPause,
                      ),
                      GestureDetector(
                        onLongPress: () {
                          onStop();
                        },
                        child: RunningCircleButton(
                          iconNamed: Icons.stop,
                          onPressed: onChange,
                        ),
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

  void onStart() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        isStart = false;
        seconds++;
        if (seconds == 60) {
          minutes += 1;
          seconds = 0;
        } else if (minutes == 60) {
          hours += 1;
          minutes = 0;
        }
      });
    });
  }

  void onPause() {
    setState(() {
      isStart = !isStart;
    });
    _timer?.cancel();
  }

  void onStop() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => UnderChallengeScreenEnd(),
        ),
            (route) => false);
  }
  void onChange() {

  }
}
import 'package:another/constant/color.dart';
import 'package:another/screens/running/running.dart';
import 'package:another/screens/running/timer_screen.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:another/widgets/go_back_appbar_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/target.dart';
import 'widgets/before_running_map.dart';

class ChallengeRunning extends StatelessWidget {
  String runningTime;
  String runningDistance;
  String kcal;
  String speed;

  ChallengeRunning({
    required this.runningTime,
    required this.runningDistance,
    required this.kcal,
    required this.speed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBarStyle(),
      body: Stack(
        children: [
          BeforeRunningMap(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  color: BACKGROUND_COLOR,
                  child: Target(
                    targetname: '목표기록',
                    runningDistance: runningDistance,
                    kcal: kcal,
                    runningTime: runningTime,
                    speed: speed,
                  ),
                ),
                SizedBox(
                  height: 300.0,
                ),
                RunningCircleButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => TimerScreen(
                            path: '/UnderChallenge',
                            // 수정 필요함
                            initialPosition:
                                CameraPosition(target: LatLng(0, 0), zoom: 30),
                          ),
                        ),
                        (route) => route.settings.name == '/');
                  },
                  iconNamed: Icons.play_arrow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

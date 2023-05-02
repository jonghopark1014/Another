import 'package:another/constant/color.dart';
import 'package:another/screens/running/timer_screen.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:another/widgets/go_back_appbar_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/target.dart';
import 'widgets/before_running_map.dart';

class ChallengeRunning extends StatelessWidget {
  const ChallengeRunning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBarStyle(),
      body: Stack(
        children: [
          beforeRunningMap(
            CameraPosition(target: LatLng(37.523327, 126.921252), zoom: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  color: BACKGROUND_COLOR,
                  child: Target(
                    targetname: '목표기록',
                  ),
                ),
                SizedBox(
                  height: 300.0,
                ),
                RunningCircleButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => TimerScreen(),
                          settings: RouteSettings(
                            arguments: '/UnderChallenge',
                          ),
                        ),
                        (route) => false);
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

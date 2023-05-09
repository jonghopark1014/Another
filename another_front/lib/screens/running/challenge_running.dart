import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:another/constant/color.dart';
import 'package:another/main.dart';
import 'package:another/screens/running/timer_screen.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:another/widgets/go_back_appbar_style.dart';


import '../../widgets/target.dart';
import 'widgets/before_running_map.dart';

class ChallengeRunning extends StatefulWidget {


  ChallengeRunning({

    Key? key,
  }) : super(key: key);

  @override
  State<ChallengeRunning> createState() => _ChallengeRunningState();
}

class _ChallengeRunningState extends State<ChallengeRunning> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List<String>;
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
                    runningDistance: arguments[0].toString(),
                    runningTime: arguments[1].toString(),
                    kcal: arguments[2].toString(),
                    speed: arguments[3].toString(),
                  ),
                ),
                SizedBox(
                  height: 300.0,
                ),
                RunningCircleButton(
                  onPressed: goTimeScreen,
                  iconNamed: Icons.play_arrow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void goTimeScreen() {
    final runningData = Provider.of<RunningData>(context, listen: false);
    runningData.reset();
    runningData.addLocation(runningData.currentPosition.target);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => TimerScreen(
            path: '/UnderChallenge',
            // 수정 필요함
            initialPosition: runningData.currentPosition,
          ),
        ),
        (route) => route.settings.name == '/');
  }
}

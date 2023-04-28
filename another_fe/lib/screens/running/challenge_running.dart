import 'package:another/constant/color.dart';
import 'package:another/screens/running/timer_screen.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/target.dart';

class ChallengeRunning extends StatelessWidget {
  const ChallengeRunning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'challenge Running',
          style: TextStyle(
            color: WHITE_COLOR,
          ),
        ),
        backgroundColor: BACKGROUND_COLOR,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.navigate_before,
            size: 40.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Target(
              targetname: '목표기록',
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
                        arguments: 'UnderChallenge',
                      ),
                    ),
                    (route) => false);
              },
              iconNamed: Icons.play_arrow,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:another/screens/running/timer_screen.dart';
import 'package:another/screens/running/widgets/running_carousel.dart';
import 'package:another/screens/running/widgets/running_my_history.dart';
import 'package:another/screens/running/widgets/running_setting_button.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:flutter/material.dart';

class RunningTab extends StatelessWidget {
  const RunningTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RunningCarousel(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RunningSettingButton(),
                // RunningCircleButton(iconNamed: Icons.play_arrow, onPressed: onPressed()),
                RunningCircleButton(
                  iconNamed: Icons.play_arrow,
                ),
                RunningMyHIstoryButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 타이머 페이지로 context?
  // void onPressed() {
  //   Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (_) => TimerScreen()), (route) => false);
  // }
}

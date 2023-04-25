import 'package:another/screens/running/widgets/running_carousel.dart';
import 'package:another/screens/running/widgets/running_my_history.dart';
import 'package:another/screens/running/widgets/running_setting_button.dart';
import 'package:another/screens/running/widgets/running_start_button.dart';
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
                RunningStartButton(),
                RunningMyHIstoryButton(),
              ],
            ),
          )
        ],
      ),
    );
  }
}




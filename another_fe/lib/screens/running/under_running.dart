import 'package:another/screens/running/under_running_end.dart';
import 'package:flutter/material.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';

import '../../widgets/record_result.dart';

class UnderRunning extends StatefulWidget {
  const UnderRunning({Key? key}) : super(key: key);

  @override
  State<UnderRunning> createState() => _UnderRunningState();
}

class _UnderRunningState extends State<UnderRunning> {
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
                SizedBox( height: 282, ),
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
          builder: (_) => UnderRunningScreenEnd(),
        ),
            (route) => false);
  }
}


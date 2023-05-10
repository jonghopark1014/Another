import 'package:another/constant/color.dart';
import 'package:another/constant/text_style.dart';
import 'package:another/screens/feed/challenge_list.dart';
import 'package:flutter/material.dart';

import '../../running/challenge_running.dart';

class RunIcon extends StatelessWidget {
  String runCount;
  String runningId;

  RunIcon({required this.runCount, required this.runningId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChallengeList(runningId: runningId),
            ),
          );
        },
        child: SizedBox(
          width: 45.0,
          child: Stack(
            children: [
              Icon(
                Icons.directions_run,
                size: 30.0,
                color: WHITE_COLOR,
              ),
              Positioned(
                left: 14,
                child: Icon(
                  Icons.directions_run,
                  size: 30.0,
                  color: WHITE_COLOR,
                ),
              )
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChallengeList(runningId: runningId),
            ),
          );
        },
        child: Text(runCount , style: MyTextStyle.sixteenTextStyle),
      ),
      SizedBox(
        width: 10.0,
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChallengeRunning(),
              settings: RouteSettings(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MAIN_COLOR,
        ),
        child: Text('기록에 도전하기'),
      ),
    ]);
  }
}

import 'package:another/constant/color.dart';
import 'package:another/screens/running/running_feed_complete.dart';
import 'package:another/screens/running/under_challenge_end_feed.dart';
import 'package:another/widgets/record_result.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/material.dart';

import '../feed/widgets/line_chart_custom.dart';

class UnderChallengeScreenEnd extends StatelessWidget {
  final List<PacesData> chartData = [
    PacesData(0, 35),
    PacesData(1, 28),
    PacesData(2, 34),
    PacesData(3, 32),
    PacesData(4, 40),
    PacesData(5, 45),
    PacesData(6, 45),
    PacesData(7, 45),
    PacesData(8, 45),
    PacesData(9, 45),
    PacesData(10, 45),
    PacesData(11, 45),
    PacesData(12, 45),
    PacesData(13, 45),
    PacesData(14, 45),
    PacesData(15, 45),
    PacesData(16, 45),
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final String timeResult =
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Target(targetname: '목표 기록'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: RecordResult(
                  timer: timeResult,
                ),
              ),
              Container(
                width: 350.0,
                height: 180.0,
                child: Chart(
                  chartData: chartData,
                ),
              ),
              ButtonConponent(
                onPressed: () => endFeed(context),
                feedComplete: () => feedComplete(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void endFeed(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => UnderChallengeScreenEndFeed(),
      ),
      (route) => false,
    );
  }

  void feedComplete(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RunningFeedComplete()),
    );
  }
}

class ButtonConponent extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback feedComplete;

  const ButtonConponent({
    required this.feedComplete,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: feedComplete,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              primary: SERVETWO_COLOR,
              elevation: 10.0,
            ),
            child: Text(
              '다음에 할래요!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: MAIN_COLOR,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              elevation: 10.0,
            ),
            child: Text(
              '오운완 등록하기',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}



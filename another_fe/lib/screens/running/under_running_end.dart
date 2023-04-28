import 'package:another/constant/color.dart';
import 'package:another/screens/running/under_challenge_end_feed.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/material.dart';

class UnderRunningScreenEnd extends StatelessWidget {
  const UnderRunningScreenEnd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Column(
            children: [
              Target(targetRecord: '내 기록'),
              Container(
                height: 300.0,
                color: WHITE_COLOR,
              ),
              SizedBox( height: 120, ),
              ButtonConponent(
                onPressed: () => EndFeed(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void EndFeed(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => UnderChallengeScreenEndFeed(),
        ),
            (route) => false);
  }
}

class ButtonConponent extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonConponent({
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
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil( '/', (route) => false, );
            },
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

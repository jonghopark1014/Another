import 'package:another/constant/color.dart';
import 'package:another/screens/running/timer_screen.dart';
import 'package:flutter/material.dart';

import '../running/under_challenge.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: BACKGROUND_COLOR,
          title: Text('로고'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '전체피드',
                    style: TextStyle(
                      color: WHITE_COLOR,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    '나의피드',
                    style: TextStyle(
                      color: WHITE_COLOR,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TimerScreen()));
              },
              child: Text('Timer'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => UnderChallenge()));
              },
              child: Text('underChallenge'),
            )
          ],
        ),
      ),
    );
  }
}

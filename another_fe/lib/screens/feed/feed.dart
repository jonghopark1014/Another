import 'package:another/constant/color.dart';
import 'package:another/screens/running/timer_screen.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '3',
              style: TextStyle(
                color: MAIN_COLOR,
                fontSize: 80.0,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => TimerScreen()));
            },
            child: Text('Timer'),
          )
        ],
      ),
    );
  }
}

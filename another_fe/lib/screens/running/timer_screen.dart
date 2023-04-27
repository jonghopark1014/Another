import 'dart:async';

import 'package:another/screens/running/under_challenge.dart';
import 'package:flutter/material.dart';

import '../../constant/color.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Timer _timer;
  int _seconds = 3;

  // 3초부터 카운터 다운 시작

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    _start();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  '$_seconds',
                  style: TextStyle(
                      fontSize: 100.0,
                      fontWeight: FontWeight.w700,
                      color: MAIN_COLOR),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _start() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (_seconds != 1) {
          setState(() {
            _seconds--;
          });
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => UnderChallenge(),
              ),
              (route) => false);
        }
      },
    );
  }
}

import 'dart:async';

import 'package:another/screens/running/under_challenge.dart';
import 'package:another/screens/running/under_running.dart';
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
  bool first = true;

  // 3초부터 카운터 다운 시작

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (first) {
      _start(arguments);
      first = false;
    }
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

  void _start(Object? arg) {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (_seconds != 1) {
          setState(() {
            _seconds -= 1;
          });
        } else {
          // 이 timer_screen로 라우팅 할때, main.dart에 경로 추가하고 밑처럼 argument로 경로 넘겨주기
          // MaterialPageRoute(
          //     builder: (_) => TimerScreen(),
          //     settings: RouteSettings(
          //       arguments: 'UnderRunning', <-- 요기
          //     )
          // )
          Navigator.of(context).pushNamedAndRemoveUntil(arg.toString(), (route) => false);
        }
      },
    );
  }
}

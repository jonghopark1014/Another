import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constant/const/color.dart';

class TimerScreen extends StatefulWidget {

  final String path;
  final CameraPosition initialPosition;
  const TimerScreen(
      {required this.path,
      required this.initialPosition,
      Key? key})
      : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Timer _timer;
  int _seconds = 3;

  @override
  void initState() {
    super.initState();
    _start(widget.path, widget.initialPosition);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  // 3초부터 카운터 다운 시작

  @override
  Widget build(BuildContext context) {
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

  void _start(String path, CameraPosition initialPosition) {
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
          Navigator.of(context).pushNamedAndRemoveUntil(
            path,
            arguments: initialPosition,
            (route) => route.settings.name == '/',
          );
        }
      },
    );
  }
}

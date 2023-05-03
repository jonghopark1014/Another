import 'package:another_front_wear_os/common/const/color.dart';
import 'package:another_front_wear_os/screen/watch_running_record.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:wearable_rotary/wearable_rotary.dart';

class WatchTimeScreen extends StatefulWidget {
  const WatchTimeScreen({super.key});

  @override
  State<WatchTimeScreen> createState() => _WatchTimeScreenState();
}



class _WatchTimeScreenState extends State<WatchTimeScreen> {
  late Timer _timer;
  int _second = 3;

  @override
  void initState() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
          (timer) {
        if (_second != 1) {
          setState(() {
            _second--;
          });
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => WatchRunningRecord(),
              ),
                  (route) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$_second',
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: 100.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

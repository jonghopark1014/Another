import 'package:another_front_wear_os/common/const/color.dart';
import 'package:another_front_wear_os/screen/watch_running_record.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class WatchTimeScreen extends StatefulWidget {
  final bool connected;
  const WatchTimeScreen({
    required this.connected,
    super.key,
  });

  @override
  State<WatchTimeScreen> createState() => _WatchTimeScreenState();
}

class _WatchTimeScreenState extends State<WatchTimeScreen> {
  late Timer _timer;
  int _second = 3;
  bool connected = false;
  @override
  void initState() {
    if(widget.connected){
      connected = true;
      timeCount();
    } else{
      timeCount();
    }
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  void timeCount() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
          (timer) {
        if (_second != 1) {
          setState(() {
            _second--;
          });
        } else {
          goRunning();
        }
      },
    );
  }


  void goRunning() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => WatchRunningRecord(
              connected : connected
          ),
        ),
            (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$_second',
          style: const TextStyle(
            color: MAIN_COLOR,
            fontSize: 100.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

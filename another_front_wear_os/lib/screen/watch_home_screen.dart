import 'package:another_front_wear_os/common/const/color.dart';
import 'package:another_front_wear_os/screen/watch_time_screen.dart';
import 'package:flutter/material.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

class WatchHomeScreen extends StatefulWidget {
  const WatchHomeScreen({super.key});

  @override
  State<WatchHomeScreen> createState() => _WatchHomeScreenState();
}

class _WatchHomeScreenState extends State<WatchHomeScreen> {
  final WatchConnectivityBase _watch = WatchConnectivity();

  bool _connected = false;

  @override
  void initState() {
    super.initState();
    _initWear();
  }

  @override
  void dispose() {
    super.dispose();
    _initWear();
  }

  void _initWear() {
    _watch.messageStream.listen(
      (message) => setState(() {
        _connected = true;
        goRunning();
      }),
    );
  }

  void _send(message) {
    _watch.sendMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                '오늘도 힘차게',
                style: TextStyle(
                    color: MAIN_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              const Text(
                '달려볼까요?🏃🏻🏃🏻‍♂🏃🏻‍♀‍',
                style: TextStyle(
                    color: MAIN_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MAIN_COLOR,
                    ),
                    onPressed: goRunning,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        '러닝시작',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goRunning() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (_) => const WatchTimeScreen(),
      ),
    );
  }
}

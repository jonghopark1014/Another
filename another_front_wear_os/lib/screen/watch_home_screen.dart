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
    _initWear();
    super.dispose();
  }

  void _initWear() {
    _watch.messageStream.listen(
      (message) => setState(() {
        if (message.containsKey('start')) {
          _connected = true;
          print(message);
          goRunning();
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                '오늘도 어나더와\n힘차게 달려볼까요?\n🏃🏻🏃🏻‍♂🏃🏻‍♀‍',
                style: TextStyle(
                    color: WHITE_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 6.0,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '앱',
                      style: TextStyle(
                        color: MAIN_COLOR,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                    TextSpan(
                      text: '에서 실행해주세요',
                      style: TextStyle(
                          color: WHITE_COLOR,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goRunning() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => WatchTimeScreen(
          connected: _connected,
        ),
      ),
      (route) => false,
    );
  }
}

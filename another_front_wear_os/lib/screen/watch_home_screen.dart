import 'package:another_front_wear_os/common/const/color.dart';
import 'package:another_front_wear_os/screen/watch_time_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_connectivity/watch_connectivity.dart';


class WatchHomeScreen extends StatefulWidget {
  const WatchHomeScreen({super.key});

  @override
  State<WatchHomeScreen> createState() => _WatchHomeScreenState();
}

class _WatchHomeScreenState extends State<WatchHomeScreen> {

  final WatchConnectivityBase _watch = WatchConnectivity();
  final MethodChannel channel = MethodChannel('watch_connectivity');
  bool _connected = false;
  var _supported = false;
  var _paired = false;
  var _reachable = false;
  late Map<String?, dynamic> startMessage;
  @override
  void initState() {
    super.initState();
    initPlatformState();
    _initWear();
  }

  void _initWear() {
    _watch.messageStream.listen((message) =>
        setState(() {
      startMessage = message;

      _connected = true;
    }),
    );
  }

  void _send(message) {
    debugPrint("Sent message: $message");
    _watch.sendMessage(message);
  }

  void initPlatformState() async {
    _supported = await _watch.isSupported;
    _paired = await _watch.isPaired;
    _reachable = await _watch.isReachable;
    setState(() {});
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
              Container(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MAIN_COLOR,
                    ),
                    child: const Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        '러닝시작',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      // if (startMessage['start'] == 0)
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                          const WatchTimeScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

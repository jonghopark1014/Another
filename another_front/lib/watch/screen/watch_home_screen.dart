
import 'package:another/constant/const/color.dart';
import 'package:another/watch/screen/watch_time_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_connectivity/watch_connectivity.dart';


class WathchHomeScreen extends StatefulWidget {
  const WathchHomeScreen({super.key});

  @override
  State<WathchHomeScreen> createState() => _WathchHomeScreenState();
}

class _WathchHomeScreenState extends State<WathchHomeScreen> {

  late final WatchConnectivityBase _watch;
  late final MethodChannel _channel;
  var _supported = false;
  var _paired = false;
  var _reachable = false;
  final _log = <String>[];
  var _context = <String, dynamic>{};
  var _receivedContexts = <Map<String, dynamic>>[];

  Future<List<Map<String, dynamic>>> get receivedApplicationContexts async {
    final receivedApplicationContexts =
    await _channel.invokeListMethod<Map>('receivedApplicationContexts');
    return receivedApplicationContexts
        ?.map((e) => e.cast<String, dynamic>())
        .toList() ??
        [];
  }


  @override
  void initState() {
    super.initState();

    _watch = WatchConnectivity();
    _channel= WatchConnectivity().channel;
    _watch.messageStream
        .listen((e) => setState(() => _log.add('Received message: $e')));
    initPlatformState();
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

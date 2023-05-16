import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:is_wear/is_wear.dart';

import 'package:watch_connectivity/watch_connectivity.dart';
// import 'package:watch_connectivity_garmin/watch_connectivity_garmin.dart';
import 'package:wear/wear.dart';

late final bool isWear;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  isWear = (await IsWear().check()) ?? false;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final WatchConnectivityBase _watch;

  var _count = 0;

  var _supported = false;
  var _paired = false;
  var _reachable = false;
  final _log = <String>[];

  Timer? timer;

  @override
  void initState() {
    super.initState();

    _watch = WatchConnectivity();
    _watch.messageStream
        .listen((e) => setState(() => _log.add('Received message: $e')));

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void initPlatformState() async {
    _supported = await _watch.isSupported;
    _paired = await _watch.isPaired;
    _reachable = await _watch.isReachable;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final home = Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Supported: $_supported'),
                Text('Paired: $_paired'),
                Text('Reachable: $_reachable'),

                TextButton(
                  onPressed: initPlatformState,
                  child: const Text('Refresh'),
                ),
                const SizedBox(height: 8),
                const Text('Send'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: sendMessage,
                      child: const Text('Message'),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: toggleBackgroundMessaging,
                  child: Text(
                    '${timer == null ? 'Start' : 'Stop'} background messaging',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 16),
                const Text('Log'),
                ..._log.reversed.map(Text.new),
              ],
            ),
          ),
        ),
      ),
    );

    return MaterialApp(
      home: isWear
          ? AmbientMode(
        builder: (context, mode, child) => child!,
        child: home,
      )
          : home,
    );
  }

  void sendMessage() {
    final message = {'data': 'Hello'};
    _watch.sendMessage(message);
    setState(() => _log.add('Sent message: $message'));
    print(_watch.sendMessage(message));
  }

  void sendContext() {
    _count++;
    final context = {'data': _count};
    _watch.updateApplicationContext(context);
    setState(() => _log.add('Sent context: $context'));
  }

  void toggleBackgroundMessaging() {
    if (timer == null) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) => sendMessage());
    } else {
      timer?.cancel();
      timer = null;
    }
    setState(() {});
  }
}
import 'dart:convert';

import 'package:another_front_wear_os/common/const/color.dart';
import 'package:another_front_wear_os/screen/watch_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'package:is_wear/is_wear.dart';
import 'package:provider/provider.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

import 'package:another/main.dart';

late final bool isWear;



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // receiveDataFromPhone();
  isWear = (await IsWear().check()) ?? false;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String appName = "another",
      phonePreference = "Phone Preference",
      keyConnect = "Connect",
      keyStart = "Start";

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => RunningData()),
      ],
      child: MaterialApp(
        home: WatchHomeScreen(),
        theme: ThemeData(
          platform: TargetPlatform.android,
          scaffoldBackgroundColor: BACKGROUND_COLOR,
        ),
      ),
    );
  }
}
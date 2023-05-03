import 'package:another_front_wear_os/common/const/color.dart';
import 'package:another_front_wear_os/screen/watch_home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(

      home: const HomeScreen(),
      theme: ThemeData(
          platform: TargetPlatform.android,
          scaffoldBackgroundColor: BACKGROUND_COLOR),
    ),
  );
}





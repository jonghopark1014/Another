import 'package:another/constant/color.dart';
import 'package:another/screens/home_screen.dart';
import 'package:another/screens/running/running.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'pretendard',
      textTheme: TextTheme(
        headline1: TextStyle(
          color: MAIN_COLOR,
          fontFamily: 'pretendard',
          fontSize: 50.0
        )
      )
    ),
    home: HomeScreen(

    ),
  ));
}

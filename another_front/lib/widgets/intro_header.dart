import 'package:flutter/material.dart';
import '../constant/const/color.dart';

class IntroHeader extends StatelessWidget {
  const IntroHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20),
          Image.asset(
          'assets/img/logo_login.png',
            height: 180,
            width: 120
          ),
          SizedBox(height: 60),
          Text(
            '함께하는 즐거운 러닝',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: SERVEONE_COLOR,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          Text(
            '몸을 움직이는 즐거움, 시작해볼까요?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: SERVEONE_COLOR,
            ),
            textAlign: TextAlign.center,
          ),
        ]
      )
    );
  }
}
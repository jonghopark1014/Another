import 'dart:async';
import 'dart:math';

import 'package:another/constant/const/color.dart';
import 'package:another_front_wear_os/screen/watch_home_screen.dart';
import 'package:flutter/material.dart';

class WatchEndText extends StatefulWidget {
  const WatchEndText({Key? key}) : super(key: key);

  @override
  State<WatchEndText> createState() => _WatchEndTextState();
}

class _WatchEndTextState extends State<WatchEndText> {
  List<String> encouragementList = [
    "오늘도 당신은 지구의\n발자취를 남기셨습니다!\n😁😀😊",
    "오늘도 멋진 당신의\n미래를 위해 수고하셨습니다\n😉😊☺",
    "잘했어요!\n오늘의 운동은 정말 멋졌어요\n😍😃😆",
    "정말 대단해요!\n당신의 노력과 헌신에\n감탄합니다\n항상 당신을 응원합니다\n😎🥰😁",
    "계속해서 목표를 향해\n 달려가는 당신을 응원합니다\n☺😚🙂",
    '운동의 근본은\n지금 이 순간입니다\n오늘도 최선을 다한 \n당신을 칭찬해요\n🤩😝😊',
    '당신은 운동을 통해\n자신을 돌봐주고 성장하는\n멋진 모습입니다\n😋🙂🤗',
  ];
  Random random = Random();
  late int randomIndex;
  late String randomEncouragement;

  @override
  void initState() {
    super.initState();
    randomIndex = random.nextInt(encouragementList.length);

    _navigateToNextScreenAfterDelay();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _navigateToNextScreenAfterDelay() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const WatchHomeScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          encouragementList[3],
          style: const TextStyle(
            color: MAIN_COLOR,
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// 지도를 매번 setState로 매초 다시 그리면 터짐
// 그래서 따로 뺌
import 'dart:async';
import 'dart:math';

import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:another/widgets/record_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../api/under_running_api.dart';
import '../under_running_end.dart';

class RunningStatus extends StatefulWidget {
  const RunningStatus({Key? key})
      : super(key: key);

  @override
  State<RunningStatus> createState() => _RunningStatus();
}

class _RunningStatus extends State<RunningStatus> {
  int _userWeight = 0;
  String runDataId = '0';
  final int timeInterval = 5;
  // 칼로리
  int userCalories = 0;
  // 페이스
  String userPace = "0'00''";
  // 시작 시간
  DateTime startTime = DateTime.now();
  // 거리
  double runningDistance = 0;
  // 시간
  String runningTime = '00:00:00';
  late Timer _timer;

  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  late bool isStart;

  // 페이스 계산 -> 1km을 도달하는 시간
  void setData() {
    final runningData = Provider.of<RunningData>(context, listen: false);

    // 거리 계산
    double nowDistance = runningData.runningDistance;
    LatLng past = runningData.preValue;
    LatLng current = runningData.curValue;

    // 러닝 시간
    runningTime =
    '${hours.toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
    runningData.setTime(runningTime);
    print("======================================");
    print(runningData.runningTime);
    print(runningData.location);


    if (runningData.location.length > 1) {
      nowDistance += 2 *
          6371 *
          asin(sqrt(
              pow(sin((current.latitude - past.latitude) / 2 * pi / 180), 2) +
                  cos(past.latitude * pi / 180) *
                      cos(current.latitude * pi / 180) *
                      pow(
                          sin((current.longitude - past.longitude) /
                              2 *
                              pi /
                              180),
                          2)));
      runningData.setDistance(nowDistance);
      runningDistance = double.parse(nowDistance.toStringAsFixed(1));


      // 페이스 계산
      double timeToSec = (hours * 3600 + minutes * 60 + seconds).toDouble();
      int paceBase = 0;
      if (runningDistance != 0) {
        paceBase = (timeToSec ~/ runningDistance);
      }
      int paceMin = paceBase ~/ 60;
      int paceSec = paceBase % 60;
      userPace = "${paceMin.toString()}'${paceSec.toString()}''";
      runningData.setPace(userPace);

      // 칼로리 계산
      userCalories = (_userWeight * runningDistance * 1.036 ~/ 1);
      runningData.setCalories(userCalories);

      // Kafka.sendTopic(latitude: current.latitude, longitude: current.longitude, runningId: runDataId, runningDistance: runningDistance, runningTime: runningTime, userCalories: userCalories, userPace: userPace);
    }
  }

  // 시간초는 거리 갱신할때도 쓰면 좋아서 그대로 흘러감
  // 대신 저장의 유무를 정지, 시작의 상태에 따라서 저장
  @override
  void initState() {
    super.initState();
    // 유저 정보 받아오기
    final userInfo = context.read<UserInfo>();
    _userWeight = userInfo.weight;
    String userId = userInfo.userId.toString();
    String forRunId1 = DateFormat('yyMMddHHmmss').format(DateTime.now());
    runDataId = userId + forRunId1;
    // 타이머 시작
    isStart = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (isStart) {
          seconds++;
          if (seconds == 60) {
            minutes += 1;
            seconds = 0;
          } else if (minutes == 60) {
            hours += 1;
            minutes = 0;
          }
          setData();
        }
      });
    });
  }

  @override
  void dispose() {
    print('timer cancel=====================================');
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return // 달릴 때 데이터 표시
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RecordResult(
              timer: runningTime,
              distance: runningDistance.toString(),
              calories: userCalories.toString(),
              pace: userPace,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // RunningCircleButton(iconNamed: Icons.play_arrow,onPressed: ,),
                isStart
                    ? RunningCircleButton(
                  iconNamed: Icons.pause,
                  onPressed: onPause,
                )
                    : RunningCircleButton(
                  iconNamed: Icons.play_arrow,
                  onPressed: onStart,
                ),
                GestureDetector(
                  onLongPress: () {
                    onStop();
                  },
                  child: RunningCircleButton(
                    iconNamed: Icons.stop,
                    onPressed: onChange,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }

  // 시작 버튼을 누르면 동작 => 시간 갱신 시작
  void onStart() {
    setState(() {
      isStart = true;
    });
  }

  // 정지 버튼을 누르면 동작 => 시간 갱신 정지
  void onPause() {
    setState(() {
      isStart = false;
    });
    // _timer?.cancel();
  }

  // 러닝 종료 시 동작
  void onStop() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => UnderRunningScreenEnd(),
        ),
            (route) => route.settings.name == '/');
  }

  void onChange() {}
}

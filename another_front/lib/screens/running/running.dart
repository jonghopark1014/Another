import 'dart:async';
import 'package:another/constant/const/color.dart';
import 'package:another/screens/running/challenge_running.dart';
import 'package:another/screens/running/timer_screen.dart';
import 'package:another/screens/running/widgets/before_running_map.dart';
import 'package:another/screens/running/widgets/detail_setting.dart';
import 'package:another/screens/running/widgets/my_history.dart';
import 'package:another/screens/running/widgets/running_carousel.dart';
import 'package:another/screens/running/widgets/running_small_button.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

import '../../main.dart';

class RunningTab extends StatefulWidget {
  const RunningTab({Key? key}) : super(key: key);
  @override
  State<RunningTab> createState() => _RunningTabState();
}

class _RunningTabState extends State<RunningTab> {
  BeforeRunningMap beforeRunningMap = BeforeRunningMap();

  final WatchConnectivityBase _watch = WatchConnectivity();
  final MethodChannel channel = MethodChannel('watch_connectivity');
  var _supported = false;
  var _paired = false;
  var _reachable = false;
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  
  void _initWear() {
    _watch.messageStream.listen((message) => setState(() {
      _connected = true;
    }));
  }

  Future<void> _send(message) async {
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
      body: Stack(children: [
        // 러닝중 지도 ====================================================
        BeforeRunningMap(),
        // 러닝 전 화면 =============================
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RunningCarousel(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RunningSmallButton(
                    iconNamed: Icons.settings,
                    onPressed: toSetting,
                  ),
                  // RunningCircleButton(iconNamed: Icons.play_arrow, onPressed: onPressed()),
                  RunningCircleButton(
                    iconNamed: Icons.play_arrow,
                    onPressed: () {
                      onPressed('/UnderRunning');
                      _send({'start': true});
                    },
                  ),
                  RunningSmallButton(
                    iconNamed: Icons.list,
                    onPressed: toHistory,
                  ),
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }

  // 세팅 페이지로
  Future<dynamic> toSetting() {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: BACKGROUND_COLOR,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            height: 280,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 25,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: CONTOUR_COLOR,
                            ))),
                    child: Text(
                      '목표설정',
                      style: TextStyle(
                        color: SERVETWO_COLOR,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SettingName(typeName: '거리(km)'),
                            SettingName(typeName: '시간(분)'),
                            SettingName(typeName: '인터벌'),
                          ],
                        ),
                        DetailSetting(),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      primary: MAIN_COLOR,
                    ),
                    child: const Text(
                      '러닝 시작!',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      onPressed('/UnderRunning');
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // 최근기록 페이지로
  Future<dynamic> toHistory() {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: BACKGROUND_COLOR,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            height: 1000,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    child: Center(
                      child: Text(
                        '최근에 내가 달린 기록',
                        style: TextStyle(
                          color: WHITE_COLOR,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: MyHistory(),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      primary: MAIN_COLOR,
                    ),
                    onPressed: () {
                      final runningData = Provider.of<RunningData>(context, listen: false);
                      if (runningData.currentPosition.target.longitude != 0 &&
                          runningData.currentPosition.target.latitude != 0) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ChallengeRunning()),
                        );
                      }

                    },
                    child: const Text(
                      '선택 완료',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // 타이머 페이지로 context
  void onPressed(String str) {
    final runningData = Provider.of<RunningData>(context, listen: false);
    runningData.reset();
    runningData.firstMinMax(runningData.currentPosition.target);
    runningData.addLocation(runningData.currentPosition.target, 1);

    // currentposition 초기값 그대로이면 받아오기전으로 판단
    if (runningData.currentPosition.target.longitude != 0 &&
        runningData.currentPosition.target.latitude != 0) {
      final userId = (Provider.of<UserInfo>(context, listen: false).userId).toString();
      String forRunId = DateFormat('yyMMddHHmmss').format(DateTime.now());
      String runDataId = userId + forRunId;
      runningData.setRunningId(runDataId);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => TimerScreen(
            path: str,
            initialPosition: runningData.currentPosition,
          ),
        ),
            (route) => false,
      );
    }
  }
}

// 세팅 종류
class SettingName extends StatelessWidget {
  final String typeName;
  const SettingName({
    required this.typeName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Text(
        typeName,
        style: TextStyle(
          color: SERVEONE_COLOR,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

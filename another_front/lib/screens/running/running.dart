import 'dart:async';

import 'package:another/constant/color.dart';
import 'package:another/screens/running/api/my_history_api.dart';
import 'package:another/screens/running/timer_screen.dart';
import 'package:another/screens/running/widgets/before_running_map.dart';
import 'package:another/screens/running/widgets/running_carousel.dart';
import 'package:another/screens/running/widgets/running_my_history.dart';
import 'package:another/screens/running/widgets/running_small_button.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class RunningTab extends StatefulWidget {
  const RunningTab({Key? key}) : super(key: key);
  @override
  State<RunningTab> createState() => _RunningTabState();
}
class _RunningTabState extends State<RunningTab> {
  BeforeRunningMap beforeRunningMap = BeforeRunningMap();
  @override
  void initState() {
    super.initState();
  }
  // @override
  // void dispose() {
  //   print('running dispose~!!!!!!=======================');
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
          children: [
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
                    onPressed: onPressed,
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
                  Row(
                    children: [
                      SettingName(typeName: '거리(km)'),
                      SettingContent(content: '거리 목표를 설정해주세요'),
                    ],
                  ),
                  Row(
                    children: [
                      SettingName(typeName: '시간(분)'),
                      SettingContent(content: '시간을 설정해주세요'),
                    ],
                  ),
                  Row(
                    children: [
                      SettingName(typeName: '인터벌'),
                      SettingContent(content: '러닝시간과 걷기 시간을 설정해주세요'),
                    ],
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
                    // 나중에 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!
                    onPressed: onPressed,
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
                    // 나중에 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!
                    onPressed: onPressed,
                    child: const Text(
                      '러닝 시작!',
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
  void onPressed() {
    final runningData = Provider.of<RunningData>(context, listen: false);
    runningData.reset();
    runningData.addLocation(runningData.currentPosition.target);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => TimerScreen(
          path: '/UnderRunning',
          initialPosition: runningData.currentPosition,
        ),
      ),
        (route) => false,
    );
  }
}

// 내기록들 띄우는 위젯
class MyHistory extends StatefulWidget {
  const MyHistory({Key? key}) : super(key: key);

  @override
  State<MyHistory> createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  List<dynamic> historyList = ['1', '2', '3', '4', '5'];
  late final _userInfo;
  late final _userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userInfo = Provider.of<UserInfo>(context, listen: false);
    // _userId = _userInfo.userId;
    _userId = 1; // 더미========================================
    var data = myHistoryApi(_userId);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: historyList.length,
      itemBuilder: (BuildContext context, int index) {
        return ElevatedButton(
          // 눌렀을 때 하이라이트
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(2),
            primary: BACKGROUND_COLOR,
          ),
          child: Target(
            targetname: '날짜',
            runningDistance: '',
            kcal: '',
            runningTime: '',
            speed: '',
          ),
        );
      },
    );
  }
}

// 세팅 내용 처리
class SettingContent extends StatelessWidget {
  final String content;
  const SettingContent({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 18,
        color: SERVETWO_COLOR,
      ),
    );
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
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

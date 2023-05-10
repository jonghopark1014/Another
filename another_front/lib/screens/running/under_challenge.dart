import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:another/main.dart';
import 'package:another/screens/running/widgets/running_map.dart';
import 'package:another/screens/running/widgets/running_status.dart';
import 'package:another/screens/running/widgets/distancebar.dart';

import 'package:another/widgets/target.dart';

class UnderChallenge extends StatefulWidget {
  UnderChallenge({Key? key}) : super(key: key);

  @override
  State<UnderChallenge> createState() => _UnderChallengeState();
}

class _UnderChallengeState extends State<UnderChallenge> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final runningData = Provider.of<RunningData>(context, listen: false);
    final initialPosition =
        ModalRoute.of(context)!.settings.arguments as CameraPosition;

    return Scaffold(
      body: Stack(
        children: [
          RunningMap(
              runningData: runningData, initialPosition: initialPosition),
          UnderChallengeStatus(initialPosition: initialPosition),
        ],
      ),
    );
  }
}

class UnderChallengeStatus extends StatefulWidget {
  final CameraPosition initialPosition;
  const UnderChallengeStatus({
    required this.initialPosition,
    Key? key,
  }) : super(key: key);

  @override
  State<UnderChallengeStatus> createState() => _UnderChallengeStatusState();
}

class _UnderChallengeStatusState extends State<UnderChallengeStatus> {
  late Timer _timer;
  late String runningId;
  late String targetRunningDistance;
  late String runningTime;
  late String userCalorie;
  late String userPace;
  late double currentRunningDistance;
  late List<double> challengeDistanceList = [];
  late var runningData;
  double currentDistance = 0;

  @override
  void initState() {
    super.initState();
    var challengeData = Provider.of<ChallengeData>(context, listen: false);
    runningId = challengeData.runningId;
    targetRunningDistance = challengeData.runningDistance;
    runningTime = challengeData.runningTime;
    userCalorie = challengeData.userCalorie;
    userPace = challengeData.userPace;
    challengeDistanceList = challengeData.challengeDistanceList;

    pace();
  }

  // 상대방 목표 거리
  // runningDistance

  // 여기에다가 변화는 값 만들어 줘야됨 (시간을 넣어주면됨)
  // double _currentSliderValue = 80.0;

  // 상대방
  // double _currentYouSliderValue = 0.0;

  @override
  void dispose() {
    super.dispose();
  }

  int second = 0;
  void pace() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (challengeDistanceList.length - 1> second) {
          setState(
            () {
              second++;
            },
          );
        } else {
          _timer.cancel();
          print('타이머 종료');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    runningData = Provider.of<RunningData>(context, listen: false);
    currentRunningDistance = runningData.runningDistance;
    if(currentRunningDistance <= double.parse(targetRunningDistance)) {
      setState(() {
        currentDistance = currentRunningDistance;
      });
    } else {
      currentDistance = double.parse(targetRunningDistance);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 25.0,
              ),
              Target(
                targetname: '목표기록',
                runningDistance: targetRunningDistance,
                userCalorie: userCalorie,
                runningTime: runningTime,
                userPace: userPace,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Stack(children: [
                  Column(
                    children: [
                      DistanceBar(
                        name: '상대 페이스',
                        pace: challengeDistanceList[second],
                        //print();
                        // 수정 주석처리만 하고 밑에 있는 값 바꾸면 됨
                        // youDistance: double.parse(targetRunningDistance),
                        youDistance: 0.832,
                      ),
                      DistanceBar(
                        name: '내 페이스',
                        pace: currentRunningDistance,
                        // youDistance: double.parse(targetRunningDistance),
                        youDistance: 0.832,
                      ),
                    ],
                  ),
                  Positioned(
                    child: AbsorbPointer(
                      absorbing: true,
                      child: SizedBox(
                        width: 400,
                        height: 150,
                      ),
                    ),
                  ),
                ]),
              ),
              RunningStatus(isChallenge: true,),
            ],
          ),
        ),
      ),
    );
  }
}

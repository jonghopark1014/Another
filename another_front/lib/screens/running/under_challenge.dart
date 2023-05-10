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
  late String runningId;
  late String targetRunningDistance;
  late String targetRunningTime;
  late String userCalorie;
  late String userPace;
  String time = '';
  int secondForIndex = 0;
  double currentRunningDistance = 0;
  List<double> challengeDistanceList = [];
  double challengeDistance = 0;
  late RunningData runningData;
  double currentDistance = 0;

  @override
  void initState() {
    super.initState();
    var challengeData = Provider.of<ChallengeData>(context, listen: false);
    runningId = challengeData.runningId;
    targetRunningDistance = challengeData.runningDistance;
    targetRunningTime = challengeData.runningTime;
    userCalorie = challengeData.userCalorie;
    userPace = challengeData.userPace;
    challengeDistanceList = challengeData.challengeDistanceList;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 러닝 데이터 받기
    runningData = Provider.of<RunningData>(context);
    time = runningData.runningTime;
    // 사용자 거리 업데이트
    currentRunningDistance = runningData.runningDistance;
    if (currentRunningDistance <= double.parse(targetRunningDistance)) {
      currentDistance = currentRunningDistance;
    } else {
      currentDistance = double.parse(targetRunningDistance);
    }
    if (secondForIndex < challengeDistanceList.length) {
      challengeDistance = challengeDistanceList[secondForIndex];
      // 인덱스로 쓰는 시간 변환
      secondForIndex = int.parse(time.substring(0, 2)) * 3600 +
          int.parse(time.substring(3, 5)) * 60 +
          int.parse(time.substring(6, 8));
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
                runningTime: targetRunningTime,
                userPace: userPace,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Stack(children: [
                  Column(
                    children: [
                      DistanceBar(
                        name: '상대 페이스',
                        pace: challengeDistance,
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
              RunningStatus(
                isChallenge: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

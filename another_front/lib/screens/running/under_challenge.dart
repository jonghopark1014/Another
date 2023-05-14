import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:another/main.dart';
import 'package:another/screens/running/widgets/running_map.dart';
import 'package:another/screens/running/widgets/running_status.dart';
import 'package:another/screens/running/widgets/distancebar.dart';

import 'package:another/widgets/target.dart';

// tts
import 'package:flutter_tts/flutter_tts.dart';

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
          AspectRatio(
            aspectRatio: 1/1,
            child: SizedBox(
                child: RunningMap(runningData: runningData, initialPosition: initialPosition)
            ),
          ),
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

  FlutterTts flutterTts = FlutterTts();

  bool q1 = false;
  bool q2 = false;
  bool q3 = false;
  bool q4 = false;

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
    double totalDis = double.parse(targetRunningDistance);
    if (totalDis / 4 <= currentRunningDistance && q1 == false) {
      q1 = true;
      playAlarm('4분의 1지점 돌파! 상대방보다 ${((currentRunningDistance - challengeDistance) * 1000).toInt()}미터 앞서고 있어요!');
    }
    else if (totalDis / 4 <= challengeDistance && q1 == false) {
      q1 = true;
      playAlarm('상대방이 4분의 1지점을 먼저 돌파했습니다. 현재 ${((challengeDistance - currentRunningDistance) * 1000).toInt()}미터 차이입니다. 화이팅!');
    }
    else if (totalDis / 2 <= currentRunningDistance && q1 == true && q2 == false) {
      q2 = true;
      playAlarm('2분의 1지점 돌파! 상대방보다 ${((currentRunningDistance - challengeDistance) * 1000).toInt()}미터 앞서고 있어요!');
    }
    else if (totalDis / 2 <= challengeDistance && q1 == true && q2 == false) {
      q2 = true;
      playAlarm('상대방이 2분의 1지점을 먼저 돌파했습니다. 현재 ${((challengeDistance - currentRunningDistance) * 1000).toInt()}미터 차이입니다. 화이팅!');
    }
    else if (3 * totalDis / 4 <= currentRunningDistance && q2 == true && q3 == false) {
      q3 = true;
      playAlarm('4분의 3지점 돌파! 상대방보다 ${((currentRunningDistance - challengeDistance) * 1000).toInt()}미터 앞서고 있어요!');
    }
    else if (3 * totalDis / 4 <= challengeDistance && q2 == true && q3 == false) {
      q3 = true;
      playAlarm('상대방이 4분의 3지점을 먼저 돌파했습니다. 현재 ${((challengeDistance - currentRunningDistance) * 1000).toInt()}미터 차이입니다. 화이팅!');
    }
    else if (totalDis <= currentRunningDistance && q3 == true && q4 == false) {
      q4 = true;
      playAlarm("도전 성공! 축하드립니다!");
    }
    else if (totalDis <= challengeDistance && q3 == true && q4 == false) {
      q4 = true;
      playAlarm("도전 실패! 이번엔 실패였지만 다음에 성공하실거에요!");
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
                        youDistance: double.parse(targetRunningDistance),
                        // youDistance: 0.832,
                      ),
                      DistanceBar(
                        name: '내 페이스',
                        pace: currentRunningDistance,
                        youDistance: double.parse(targetRunningDistance),
                        // youDistance: 0.832,
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

  // for TTS
  void initializeTTS() async {
    await flutterTts.setLanguage("ko-KR"); // TTS 언어 설정
    await flutterTts.setSpeechRate(0.5); // 음성 재생 속도 설정
    // 필요한 TTS 초기화 설정을 수행합니다.
  }

  void playAlarm(String message) async {
    await flutterTts.speak(message); // TTS로 텍스트 읽기
    // 추가적인 알람 동작을 수행합니다.
  }

}

import 'package:another/constant/const/color.dart';
import 'package:another/main.dart';
import 'package:another/screens/running/api/versus_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:another/screens/running/timer_screen.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:another/widgets/go_back_appbar_style.dart';

import '../../widgets/target.dart';
import 'widgets/before_running_map.dart';

class ChallengeRunning extends StatefulWidget {
  ChallengeRunning({
    Key? key,
  }) : super(key: key);

  @override
  State<ChallengeRunning> createState() => _ChallengeRunningState();
}

class _ChallengeRunningState extends State<ChallengeRunning> {
  late String runningId;
  late String runningDistance;
  late String runningTime;
  late String userCalorie;
  late String userPace;
  late List<double> challengeDistanceList = [];
  String runDataId = '';
  @override
  void initState() {
    super.initState();

    var challengeData = Provider.of<ChallengeData>(context, listen: false);
    runningId = challengeData.hostRunningId;
    runningDistance = challengeData.runningDistance;
    runningTime = challengeData.runningTime;
    userCalorie = challengeData.userCalorie;
    userPace = challengeData.userPace;
    print(runningId);
    _versusApi();
    print(challengeDistanceList);
    challengeData.setList(challengeDistanceList);
  }

  Future<void> _versusApi() async {
    try {
      // 수정 주석처리만 하고 밑에 있는 값 바꾸면 됨
      print('111111');
      final response = await VersusApi.getFeed(runningId);
      print('2222222$response');
      // final response = await VersusApi.getFeed('1230509055100');
      final contents = response['data'];
      print('$contents ==================================');
      for (var content in contents) {
        challengeDistanceList.add(content['runningDistance']);
      }

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBarStyle(),
      body: Stack(
        children: [
          BeforeRunningMap(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Target(
                    targetname: '목표기록',
                    runningDistance: runningDistance,
                    runningTime: runningTime,
                    userCalorie: userCalorie,
                    userPace: userPace,
                  ),
                ),
                SizedBox(
                  height: 300.0,
                ),
                RunningCircleButton(
                  onPressed: goTimeScreen,
                  iconNamed: Icons.play_arrow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void goTimeScreen() {
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
            builder: (_) =>
                TimerScreen(
                  path: '/UnderChallenge',
                  // 수정 필요함
                  initialPosition: runningData.currentPosition,
                ),
          ),
              (route) => route.settings.name == '/');
    }
  }
}

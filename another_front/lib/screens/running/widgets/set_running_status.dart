

import 'package:another/constant/color.dart';
import 'package:another/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import 'distancebar.dart';


class SetRunningStatus extends StatefulWidget {
  const SetRunningStatus({Key? key}) : super(key: key);

  @override
  State<SetRunningStatus> createState() => _SetRunningStatusState();
}

class _SetRunningStatusState extends State<SetRunningStatus> {
  FlutterTts flutterTts = FlutterTts();

  int tempIntervalTime = 100000; // sec
  int intervalFirst = 0;
  int intervalSecond = 0;
  // 설정값
  int settingDistance = 0;
  int settingSec = 0;
  List<int> settingInterval = [0,0];
  // 뛴 거리 등
  double runningDistance = 0;
  double runningTime = 0;
  @override
  void initState() {
    // TODO: implement initState
    initializeTTS();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // 설정값 가져오기
    final runningSetting = Provider.of<RunningSetting>(context);
    settingDistance = runningSetting.distance;
    settingSec = runningSetting.min * 60;
    settingInterval = runningSetting.interval;
    // 뛴 거리 등 받아오기
    final runningData = Provider.of<RunningData>(context);
    if (settingDistance != 0) {
      double convertedDistance = runningData.runningDistance;
      if (convertedDistance <= settingDistance) {
        runningDistance = convertedDistance;
      }
    }
    String tempTime = runningData.runningTime;
    if (settingSec != 0 ){
      double convertedTime = double.parse(tempTime.substring(0,2)) * 3600 + double.parse(tempTime.substring(3,5)) * 60 + double.parse(tempTime.substring(6,8));
      if (convertedTime <= settingSec) {
        runningTime = double.parse(tempTime.substring(0,2)) * 3600 + double.parse(tempTime.substring(3,5)) * 60 + double.parse(tempTime.substring(6,8));
      }
    }
    // 인터벌 로직
    if (settingInterval[0] != 0) {
      // 제일 처음에
      if (tempIntervalTime == 100000) {
        intervalFirst = 1;
        intervalSecond = 0;
        tempIntervalTime = settingInterval[0] * 60;
      }
      else {
        // First 인터벌 시간일때
        if (intervalFirst == 1) {
          tempIntervalTime--;
          // 0되면 바꾸기
          if (tempIntervalTime == 0) {
            intervalFirst = 0;
            intervalSecond = 1;
            tempIntervalTime = settingInterval[1] * 60;
            playAlarm('${settingInterval[0]} 분 지났어요!');
          }
        }
        // second 인터벌 시간일때
        else {
          tempIntervalTime--;
          // 0되면 바꾸기
          if (tempIntervalTime == 0) {
            intervalFirst = 1;
            intervalSecond = 0;
            tempIntervalTime = settingInterval[0] * 60;
            playAlarm('${settingInterval[1]} 분 지났어요!');

          }
        }
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: BACKGROUND_COLOR,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(),
          SizedBox(),
          SizedBox(),
          SizedBox(),
          settingDistance != 0 ? DistanceBar(
            pace: runningDistance,
            youDistance: settingDistance.toDouble(),
            name: '목표 거리 : ${settingDistance}km',
          ) : Container(),
          settingSec != 0 ? DistanceBar(
            pace: runningTime,
            youDistance: settingSec.toDouble(),
            name: '목표 시간 : ${(settingSec ~/ 60)}분',
          ) : Container(),
        ],
      ),
    );
  }

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

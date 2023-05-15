

import 'package:another/constant/const/color.dart';
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

  bool timeEnd = false;
  bool disEnd = false;
  bool dishalf = false;

  int tempIntervalTime = 100000; // sec
  int intervalFirst = 0;
  int intervalSecond = 0;
  // 설정값
  int settingDistance = 0;
  int settingSec = 0;
  int settingHour = 0;
  int settingMin = 0;
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
    settingHour = runningSetting.hour;
    settingMin = runningSetting.min;
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
            // intervalFirst = 0;
            // intervalSecond = 1;
            // tempIntervalTime = settingInterval[1] * 60;
            // playAlarm('첫 번째 설정 시각, ${settingInterval[0]} 분 지났어요!');
          }
        }
        // second 인터벌 시간일때
        else {
          tempIntervalTime--;
          // 0되면 바꾸기
          if (tempIntervalTime == 0) {
            // intervalFirst = 1;
            // intervalSecond = 0;
            // tempIntervalTime = settingInterval[0] * 60;
            // playAlarm('두 번째 설정 시각, ${settingInterval[1]} 분 지났어요!');

          }
        }
      }
    }
    // tts 관련 설정
    // // 전부다 설정 시
    int setSec = settingSec~/60;
    if (settingDistance != 0 && settingSec != 0 && settingInterval[0] != 0) {
      if (intervalFirst == 1 && tempIntervalTime == 0) {
        intervalFirst = 0;
        intervalSecond = 1;
        tempIntervalTime = settingInterval[1] * 60;
        if (settingDistance / 2 <= runningDistance && dishalf == false) {
          dishalf = true;
          if (settingSec / 2 == runningTime) {
            playAlarm('첫 번째 인터벌 끝! 설정 시간의 50% 달성! 설정 거리의 50% 돌파!');
          }
          else if (settingSec == runningTime && timeEnd == false) {
            timeEnd = true;
            playAlarm('첫 번째 인터벌 끝! 설정 시간 $setSec분 달성! 설정 거리의 50% 돌파!');
          }
          else {
            playAlarm('첫 번째 인터벌 끝! 설정 거리의 50% 돌파!');
          }
        }
        else if (settingDistance <= runningDistance && disEnd == false) {
          disEnd = true;
          if (settingSec / 2 == runningTime) {
            playAlarm('첫 번째 인터벌 끝! 설정 시간의 50% 달성! 설정 거리 ${settingDistance}km 완주!');
          }
          else if (settingSec == runningTime && timeEnd == false) {
            timeEnd = true;
            playAlarm('첫 번째 인터벌 끝! 설정 시간 $setSec분 달성! 설정 거리 ${settingDistance}km 완주!');
          }
          else {
            playAlarm('첫 번째 인터벌 끝! 설정 거리 ${settingDistance}km 완주!');
          }
        }
        else {
          if (settingSec / 2 == runningTime) {
            playAlarm('첫 번째 인터벌 끝! 설정 시간의 50% 달성!');
          }
          else if (settingSec == runningTime && timeEnd == false) {
            timeEnd = true;
            playAlarm('첫 번째 인터벌 끝! 설정 시간 $setSec분 달성!');
          }
          else {
            playAlarm('첫 번째 인터벌 ${settingInterval[0]}분 끝! ');
          }
        }
      }
      else if (intervalSecond == 1  && tempIntervalTime == 0) {
        intervalFirst = 1;
        intervalSecond = 0;
        tempIntervalTime = settingInterval[0] * 60;
        if (settingDistance / 2 <= runningDistance && dishalf == false) {
          dishalf = true;
          if (settingSec / 2 == runningTime) {
            playAlarm('두 번째 인터벌 끝! 설정 시간의 50% 달성! 설정 거리의 50% 돌파!');
          }
          else if (settingSec == runningTime && timeEnd == false) {
            timeEnd = true;
            playAlarm('두 번째 인터벌 끝! 설정 시간 $setSec분 달성! 설정 거리의 50% 돌파!');
          }
          else {
            playAlarm('두 번째 인터벌 끝! 설정 거리의 50% 돌파!');
          }
        }
        else if (settingDistance <= runningDistance && disEnd == false) {
          disEnd = true;
          if (settingSec / 2 == runningTime) {
            playAlarm('두 번째 인터벌 끝! 설정 시간의 50% 달성! 설정 거리 ${settingDistance}km 완주!');
          }
          else if (settingSec == runningTime && timeEnd == false) {
            timeEnd = true;
            playAlarm('듀 번째 인터벌 끝! 설정 시간 $setSec분 달성! 설정 거리 ${settingDistance}km 완주!');
          }
          else {
            playAlarm('두 번째 인터벌 끝! 설정 거리 ${settingDistance}km 완주!');
          }
        }
        else {
          if (settingSec / 2 == runningTime) {
            playAlarm('두 번째 인터벌 끝! 설정 시간의 50% 달성!');
          }
          else if (settingSec == runningTime && timeEnd == false) {
            timeEnd = true;
            playAlarm('두 번째 인터벌 끝! 설정 시간 $setSec분 달성!');
          }
          else {
            playAlarm('두 번째 인터벌 ${settingInterval[0]}분 끝! ');
          }
        }
      }
      else {
        if (settingDistance / 2 <= runningDistance && dishalf == false) {
          dishalf = true;
          if (settingSec / 2 == runningTime) {
            playAlarm('설정 시간의 50% 달성! 설정 거리의 50% 돌파!');
          }
          else if (settingSec == runningTime && timeEnd == false) {
            timeEnd = true;
            playAlarm('설정 시간 $setSec분 달성! 설정 거리의 50% 돌파!');
          }
          else {
            playAlarm('설정 거리의 50% 돌파!');
          }
        }
        else if (settingDistance <= runningDistance && disEnd == false) {
          disEnd = true;
          if (settingSec / 2 == runningTime) {
            playAlarm('설정 시간의 50% 달성! 설정 거리 ${settingDistance}km 완주!');
          }
          else if (settingSec == runningTime && timeEnd == false) {
            timeEnd = true;
            playAlarm('설정 시간 $setSec분 달성! 설정 거리 ${settingDistance}km 완주!');
          }
          else {
            playAlarm('설정 거리 ${settingDistance}km 완주!');
          }
        }
        else {
          if (settingSec / 2 == runningTime) {
            playAlarm('설정 시간의 50% 달성!');
          }
          else if (settingSec == runningTime && timeEnd == false) {
            timeEnd = true;
            playAlarm('설정 시간 $setSec분 달성!');
          }
        }
      }
    }
    // // 거리 + 인터벌
    else if (settingDistance != 0 && settingSec == 0 && settingInterval[0] != 0) {
      if (intervalFirst == 1  && tempIntervalTime == 0) {
        intervalFirst = 0;
        intervalSecond = 1;
        tempIntervalTime = settingInterval[1] * 60;
        if (settingDistance / 2 <= runningDistance && dishalf == false) {
          dishalf = true;
            playAlarm('첫 번째 인터벌 끝! 설정 거리의 50% 돌파!');
        }
        else if (settingDistance <= runningDistance && disEnd == false) {
          disEnd = true;
            playAlarm('첫 번째 인터벌 끝! 설정 거리 ${settingDistance}km 완주!');
        }
        else {
            playAlarm('첫 번째 인터벌 ${settingInterval[0]}분 끝! ');
        }
      }
      else if (intervalSecond == 1  && tempIntervalTime == 0) {
        intervalFirst = 1;
        intervalSecond = 0;
        tempIntervalTime = settingInterval[0] * 60;
        if (settingDistance / 2 <= runningDistance && dishalf == false) {
          dishalf = true;
          playAlarm('두 번째 인터벌 끝! 설정 거리의 50% 돌파!');
        }
        else if (settingDistance <= runningDistance && disEnd == false) {
          disEnd = true;
          playAlarm('두 번째 인터벌 끝! 설정 거리 ${settingDistance}km 완주!');
        }
        else {
          playAlarm('두 번째 인터벌 ${settingInterval[0]}분 끝! ');
        }
      }
      else {
        if (settingDistance / 2 <= runningDistance && dishalf == false) {
          dishalf = true;
            playAlarm('설정 거리의 50% 돌파!');
        }
        else if (settingDistance <= runningDistance && disEnd == false) {
          disEnd = true;
            playAlarm('설정 거리 ${settingDistance}km 완주!');
        }
      }
    }
    // // 시간 + 인터벌
    else if (settingDistance == 0 && settingSec != 0 && settingInterval[0] != 0) {
      print(settingSec);
      print(tempIntervalTime);
      print(intervalFirst);
      if (intervalFirst == 1  && tempIntervalTime == 0) {
        intervalFirst = 0;
        intervalSecond = 1;
        tempIntervalTime = settingInterval[1] * 60;
        if (settingSec / 2 == runningTime) {
          playAlarm('첫 번째 인터벌 끝! 설정 시간의 50% 달성!');
        }
        else if (settingSec == runningTime && timeEnd == false) {
          timeEnd = true;
          playAlarm('첫 번째 인터벌 끝! 설정 시간 $setSec분 달성!');
        }
        else {
          playAlarm('첫 번째 인터벌 끝!');
        }
      }
      else if (intervalSecond == 1  && tempIntervalTime == 0) {
        intervalFirst = 1;
        intervalSecond = 0;
        tempIntervalTime = settingInterval[0] * 60;
        if (settingSec / 2 == runningTime) {
          playAlarm('두 번째 인터벌 끝! 설정 시간의 50% 달성!');
        }
        else if (settingSec == runningTime && timeEnd == false) {
          timeEnd = true;
          playAlarm('두 번째 인터벌 끝! 설정 시간 $setSec분 달성!');
        }
        else {
          playAlarm('두 번째 인터벌 끝!');
        }
      }
      else {
        if (settingSec / 2 == runningTime) {
          playAlarm('설정 시간의 50% 달성!');
        }
        else if (settingSec == runningTime && timeEnd == false) {
          timeEnd = true;
          playAlarm('설정 시간 $setSec분 달성!');
        }
      }
    }
    // // 거리 + 시간
    else if (settingDistance != 0 && settingSec == 0 && settingInterval[0] == 0) {
      if (settingDistance / 2 <= runningDistance && dishalf == false) {
        dishalf = true;
        if (settingSec / 2 == runningTime) {
          playAlarm('설정 시간의 50% 달성! 설정 거리의 50% 돌파!');
        }
        else if (settingSec == runningTime && timeEnd == false) {
          timeEnd = true;
          playAlarm('설정 시간 $setSec분 달성! 설정 거리의 50% 돌파!');
        }
        else {
          playAlarm('설정 거리의 50% 돌파!');
        }
      }
      else if (settingDistance <= runningDistance && disEnd == false) {
        disEnd = true;
        if (settingSec / 2 == runningTime) {
          playAlarm('설정 시간의 50% 달성! 설정 거리 ${settingDistance}km 완주!');
        }
        else if (settingSec == runningTime && timeEnd == false) {
          timeEnd = true;
          playAlarm('설정 시간 $setSec분 달성! 설정 거리 ${settingDistance}km 완주!');
        }
        else {
          playAlarm('설정 거리 ${settingDistance}km 완주!');
        }
      }
      else {
        if (settingSec / 2 == runningTime) {
          playAlarm('설정 시간의 50% 달성!');
        }
        else if (settingSec == runningTime && timeEnd == false) {
          timeEnd = true;
          playAlarm('설정 시간 $setSec분 달성!');
        }
      }
    }
    // // 거리만
    else if (settingDistance != 0 && settingSec == 0 && settingInterval[0] == 0) {
        if (settingDistance / 2 <= runningDistance && dishalf == false) {
          dishalf = true;
          playAlarm('설정 거리의 50% 돌파!');
        }
        else if (settingDistance <= runningDistance && disEnd == false) {
          disEnd = true;
          playAlarm('설정 거리 ${settingDistance}km 완주!');
        }
      }
    // // 시간만
    else if (settingDistance == 0 && settingSec != 0 && settingInterval[0] == 0) {
      if (settingSec / 2 == runningTime) {
        playAlarm('설정 시간의 50% 달성!');
      }
      else if (settingSec == runningTime && timeEnd == false) {
        timeEnd = true;
        playAlarm('설정 시간 $setSec분 달성!');
      }
    }
    // // 인터벌 만
    else if (settingDistance == 0 && settingSec == 0 && settingInterval[0] != 0) {
      if (intervalFirst == 1 && tempIntervalTime == 0) {
        intervalFirst = 0;
        intervalSecond = 1;
        tempIntervalTime = settingInterval[1] * 60;
        playAlarm('첫 번째 인터벌 끝!');
      }
      else if (intervalSecond == 0 && tempIntervalTime == 0) {
        intervalFirst = 1;
        intervalSecond = 0;
        tempIntervalTime = settingInterval[0] * 60;
        playAlarm('두 번째 인터벌 끝');
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
            name: settingHour != 0 ? '목표 시간 : $settingHour시간 $settingMin분':'목표 시간 : $settingMin분',
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

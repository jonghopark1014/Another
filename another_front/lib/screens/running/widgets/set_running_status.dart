

import 'package:another/constant/color.dart';
import 'package:another/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'distancebar.dart';


class SetRunningStatus extends StatefulWidget {
  const SetRunningStatus({Key? key}) : super(key: key);

  @override
  State<SetRunningStatus> createState() => _SetRunningStatusState();
}

class _SetRunningStatusState extends State<SetRunningStatus> {
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
      double convertedDistance = runningData.runningDistance / settingDistance * 100;
      if (convertedDistance <= 100) {
        runningDistance = convertedDistance;
      }
    }
    String tempTime = runningData.runningTime;
    if (settingSec != 0 ){
      double convertedTime = (int.parse(tempTime.substring(0,2)) * 3600 + int.parse(tempTime.substring(3,5)) * 60 + int.parse(tempTime.substring(6,8))) / settingSec * 100;
      if (convertedTime <= 100) {
        runningTime = (int.parse(tempTime.substring(0,2)) * 3600 + int.parse(tempTime.substring(3,5)) * 60 + int.parse(tempTime.substring(6,8))) / settingSec * 100;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: BACKGROUND_COLOR,
      ),
      child: Column(
        children: [
          settingDistance != 0 ? DistanceBar(
            pace: runningDistance,
            name: '설정 거리',
          ) : Container(),
          settingSec != 0 ? DistanceBar(
            pace: runningTime,
            name: '설정 시간',
          ) : Container(),
        ]

      ),
    );
  }
}

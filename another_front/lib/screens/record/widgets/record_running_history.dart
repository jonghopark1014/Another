import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';
import '../../../widgets/target.dart';

class TodayRecord extends StatelessWidget {
  const TodayRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Target(
      targetname: '2023.05.02',
      runningDistance: '',
      userCalorie: '',
      runningTime: '',
      userPace: '',
    );
  }
}

class ThisWeekRecord extends StatelessWidget {
  const ThisWeekRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Target(
      targetname: '2023.05.03',
      runningDistance: '',
      userCalorie: '',
      runningTime: '',
      userPace: '',
    );
  }
}

class ThisMonthRecord extends StatelessWidget {
  const ThisMonthRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Target(
      targetname: '2023.05.04',
      runningDistance: '',
      userCalorie: '',
      runningTime: '',
      userPace: '',
    );
  }
}

class AllRecord extends StatelessWidget {
  const AllRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Target(
      targetname: '2023.05.05',
      runningDistance: '',
      userCalorie: '',
      runningTime: '',
      userPace: '',
    );
  }
}

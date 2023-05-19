import 'package:another_front_wear_os/common/const/color.dart';
import 'package:another_front_wear_os/screen/widget/watch_record_result.dart';
import 'package:flutter/material.dart';

class RecordResultBox extends StatelessWidget {
  final String runningDistance;
  final String runningTime;
  final String userCalories;
  final String userPace;

  const RecordResultBox(
      {required this.runningDistance,
        required this.runningTime,
        required this.userCalories,
        required this.userPace,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RecordResult(
              name: '시간',
              data: runningTime,
              recordColor: YELLOW_COLOR,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                width: size.width/2.5,
                height: 1.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: SERVE_COLOR,
                  ),
                ),
              ),
            ),
            RecordResult(
              name: 'Kcal',
              data: userCalories,
              recordColor: RED_COLOR,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: VerticalDivider(
            width: 1.0,
            color: SERVE_COLOR,
            thickness: 1.0,
            indent: 10.0,
            endIndent: 10.0,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RecordResult(
              name: '평균 페이스',
              data: userPace,
              recordColor: GREEN_COLOR,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                width: size.width/2.5,
                height: 1.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: SERVE_COLOR,
                  ),
                ),
              ),
            ),
            RecordResult(
              name: 'KM',
              data: runningDistance,
              recordColor: BLUE_COLOR,
            ),
          ],
        ),
      ],
    );
  }
}

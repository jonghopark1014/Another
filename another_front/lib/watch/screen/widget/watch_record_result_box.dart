import 'package:another/constant/const/color.dart';
import 'package:another/watch/screen/widget/watch_record_result.dart';
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
                width: 70.0,
                height: 1.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: SERVEONE_COLOR,
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
          padding: EdgeInsets.all(4.0),
          child: VerticalDivider(
            width: 1.0,
            color: SERVEONE_COLOR,
            thickness: 1.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RecordResult(
              name: '평균 페이스',
              data: userPace,
              recordColor: BLUE_COLOR,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                width: 70.0,
                height: 1.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: SERVEONE_COLOR,
                  ),
                ),
              ),
            ),
            RecordResult(
              name: 'KM',
              data: runningDistance,
              recordColor: GREEN_COLOR,
            ),
          ],
        ),
      ],
    );
  }
}

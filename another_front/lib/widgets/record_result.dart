import 'package:another/widgets/record_result_box.dart';
import 'package:flutter/material.dart';

import '../constant/color.dart';

class RecordResult extends StatelessWidget {
  final String timer;
  final String distance;
  final String calories;
  final String pace;

  const RecordResult({
    required this.timer,
    required this.distance,
    required this.calories,
    required this.pace,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: BLACK_COLOR,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 180.0,
        child: Column(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RecordResultBox(
                    data: timer,
                    name: '시간',
                    textColor: YELLOW_COLOR,
                    recordColor: WHITE_COLOR,
                  ),
                  RecordResultBox(
                    data: '${distance}km',
                    name: '거리',
                    textColor: BLUE_COLOR,
                    recordColor: WHITE_COLOR,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RecordResultBox(
                    data: '${calories}kcal',
                    name: '총칼로리',
                    textColor: RED_COLOR,
                    recordColor: WHITE_COLOR,
                  ),
                  RecordResultBox(
                    data: pace,
                    name: '평균페이스',
                    textColor: GREEN_COLOR,
                    recordColor: WHITE_COLOR,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
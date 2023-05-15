import 'package:another/constant/const/color.dart';
import 'package:another/watch/screen/widget/watch_record_result.dart';
import 'package:flutter/material.dart';


class RecordResultBox extends StatelessWidget {
  const RecordResultBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RecordResult(
              name: '시간',
              data: '00:00:00',
              recordColor: YELLOW_COLOR,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                width: 70.0,
                height: 1.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: SERVEONE_COLOR,
                  ),
                ),
              ),
            ),
            RecordResult(
              name: 'Kcal',
              data: '1502',
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
            indent: 25.0,
            endIndent: 25.0,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RecordResult(
              name: '평균 페이스',
              data: '10`10/km',
              recordColor: BLUE_COLOR,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                width: 70.0,
                height: 1.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: SERVEONE_COLOR,
                  ),
                ),
              ),
            ),
            RecordResult(
              name: 'KM',
              data: '1.2',
              recordColor: GREEN_COLOR,
            ),
          ],
        ),
      ],
    );
  }
}

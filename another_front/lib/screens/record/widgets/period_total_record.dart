import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';

Map<String, dynamic> dummyToday = {
  'Date': '2023. 05. 03',
  'walkCount': 25890,
  'kcal': 2500,
  'runningDistance': 8.3,
  'runningTime': '03:05:50'
};
Map<String, dynamic> dummyWeek = {
  'Date': '2023. 04. 29 ~ 2023. 05. 04',
  'walkCount': 36666,
  'kcal': 3500,
  'runningDistance': 10.2,
  'runningTime': '05:20:50'
};
Map<String, dynamic> dummyMonth = {
  'Date': '2023. 05. 01 ~ 2023. 05. 15',
  'walkCount': 68888,
  'kcal': 4900,
  'runningDistance': 15.5,
  'runningTime': '08:30:50'
};

Map<String, dynamic> dummyAll = {
  'Date': '2023. 01. 01 ~',
  'walkCount': 1000000,
  'kcal': 49000,
  'runningDistance': 155.2,
  'runningTime': '26:30:50'
};

Map<String, dynamic> dummyCalendar = {
  'Date': '선택된 날짜',
  'walkCount': 0,
  'kcal': 0,
  'runningDistance': 0,
  'runningTime': '00:00:00'
};

class PeriodTotalRecord extends StatelessWidget {
  const PeriodTotalRecord(
      {Key? key, required this.selectedIndex, this.selectedDay})
      : super(key: key);

  final int selectedIndex;
  final selectedDay;

  @override
  Widget build(BuildContext context) {
    Map <String, dynamic> dummy;

    if (selectedIndex == 0) {
      dummy = dummyToday;
    } else if (selectedIndex == 1) {
      dummy = dummyWeek;
    } else if (selectedIndex == 2) {
      dummy = dummyMonth;
    } else if (selectedIndex == 3) {
      dummy = dummyAll;
    } else if (selectedIndex == 4) {
      dummy = dummyCalendar;
    } else {
      throw Exception('Invalid selectedIndex value: $selectedIndex');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            decoration: BoxDecoration(
              color: CONTOUR_COLOR,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: BoxConstraints(
              minHeight: 150.0,
              minWidth: 320.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 12, bottom:4),
                  child: Text(
                    dummy['Date'],
                    style: TextStyle(color: SERVETWO_COLOR),
                  ),
                ),
                // Divider(thickness: 1, height: 10, color: SERVETWO_COLOR),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigTargetBox(data: dummy['walkCount'], unit: '걸음'),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          SmallTargetBox(data: dummy['runningDistance'], unit: 'km'),
                          SizedBox(width: 40),
                          SmallTargetBox(data: dummy['kcal'], unit: 'kcal'),
                          SizedBox(width: 40),
                          SmallTargetBox(data: dummy['runningTime'], unit: '시간'),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }
}

class BigTargetBox extends StatelessWidget {
  final dynamic data;
  final String unit;
  const BigTargetBox({Key? key, required this.data, required this.unit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${data}',
          style: TextStyle(
              color: MAIN_COLOR, fontSize: 36, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Text('${unit}', style: TextStyle(color: SERVEONE_COLOR, fontSize: 16))
      ],
    );
  }
}

class SmallTargetBox extends StatelessWidget {
  final dynamic data;
  final String unit;
  const SmallTargetBox({Key? key, required this.data, required this.unit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${data}',
          style: TextStyle(
              color: WHITE_COLOR, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text('${unit}', style: TextStyle(color: SERVEONE_COLOR, fontSize: 16))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:another/constant/const/color.dart';

class PeriodTotalRecord extends StatelessWidget {
  const PeriodTotalRecord(
      {Key? key,
      required this.selectedIndex,
      this.selectedDay,
      required this.recordData})
      : super(key: key);

  final int selectedIndex;
  final selectedDay;
  final Map<String, dynamic>? recordData;

  @override
  Widget build(BuildContext context) {
    return recordData == null ?
      Center(child: CircularProgressIndicator())
        : Column(
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
                padding: EdgeInsets.only(left: 20, top: 12, bottom: 4),
                child: Text(
                  selectedIndex == 0

                      ? '${recordData!['curAvg']['startDate']}'
                  : selectedIndex == 3 ? '${recordData!['startDate']} ~ ${recordData!['endDate']}'
                      : selectedIndex == 4
                          ? '${recordData!['startDate']}'
                          : '${recordData!['curAvg']['startDate']} ~ ${recordData!['curAvg']['endDate']}',

                  style: TextStyle(color: SERVETWO_COLOR),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigTargetBox(

                      data: selectedIndex == 3 || selectedIndex == 4
                          ? recordData!['sumDistance'] == 0.0 ? '-' : recordData!['sumDistance']
                          : recordData!['curAvg']['sumDistance'] == 0.0 ? '-' : recordData!['curAvg']['sumDistance'],

                      unit: 'km',
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        SmallTargetBox(

                          data: selectedIndex == 3 || selectedIndex == 4
                              ? recordData!['sumTime'] == '00:00:00' ? '-' : recordData!['sumTime']
                              : recordData!['curAvg']['sumTime'] == '00:00:00' ? '-' : recordData!['curAvg']['sumTime'],

                          unit: '시간',
                        ),
                        SizedBox(width: 40),
                        SmallTargetBox(

                          data: selectedIndex == 3 || selectedIndex == 4
                              ? recordData!['sumKcal'] == 0 ? '-' : recordData!['sumKcal']
                              : recordData!['curAvg']['sumKcal'] == 0 ? '-' : recordData!['curAvg']['sumKcal'],

                          unit: 'kcal',
                        ),
                        SizedBox(width: 40),
                        SmallTargetBox(

                          data: selectedIndex == 3 || selectedIndex == 4
                              ? recordData!['avgPace'] == "0'0''" ? '-' :  recordData!['avgPace']
                              : recordData!['curAvg']['avgPace'] == "0'0''" ? '-' : recordData!['curAvg']['avgPace'],
                          unit: '평균 페이스',

                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
          '$data',
          style: TextStyle(
              color: MAIN_COLOR, fontSize: 36, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Text('$unit', style: TextStyle(color: SERVEONE_COLOR, fontSize: 16))
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
          '$data',
          style: TextStyle(
              color: WHITE_COLOR, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text('$unit', style: TextStyle(color: SERVEONE_COLOR, fontSize: 16))
      ],
    );
  }
}

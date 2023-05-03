import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';

class PeriodTotalRecord extends StatelessWidget {
  const PeriodTotalRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              children: [
                Text('2023.05.03', style: TextStyle(color: SERVETWO_COLOR),),
                Divider(thickness: 1, height: 10, color: SERVETWO_COLOR),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigTargetBox(data: '25,789', unit: '걸음'),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          SmallTargetBox(data: '8.3', unit: 'km'),
                          SizedBox(width: 40),
                          SmallTargetBox(data: '638', unit: 'kcal'),
                          SizedBox(width: 40),
                          SmallTargetBox(data: '3:26:34', unit: '시간'),
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
  final String data;
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
  final String data;
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

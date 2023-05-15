import 'package:another/constant/const/color.dart';
import 'package:another/constant/const/text_style.dart';
import 'package:another/screens/running/widgets/distancebar_custom.dart';
import 'package:flutter/material.dart';

class DistanceBar extends StatefulWidget {
  final String name;
  final double pace;
  final double youDistance;
  DistanceBar({
    required this.pace,
    required this.name,
    required this.youDistance,
    Key? key,
  }) : super(key: key);

  @override
  State<DistanceBar> createState() => _DistanceBarState(name: name);
}

class _DistanceBarState extends State<DistanceBar> {
  final String name;
  double _progress = 0.0;
  double _previousValue = 0.0;

  _DistanceBarState({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: [
          Text(
            name,
            style: MyTextStyle.fourteenTextStyle,
            textAlign: TextAlign.start,
          ),
          SliderTheme(
            data: SliderThemeData(
              valueIndicatorTextStyle: TextStyle(
                color: WHITE_COLOR,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              activeTrackColor: MAIN_COLOR,
              inactiveTrackColor: WHITE_COLOR,
              trackHeight: 12.0,
              thumbShape: CustomSliderThumbCircle(
                thumbRadius: 20,
                min: 0,
                max: 100,
              ),
            ),
            child: Slider(
              // 현재값에 지금 거리를 넣어주면 됨
              value: widget.pace,
              min: 0,
              // 거리 widget.distance 넣어주면 될듯 함 상대방의 거리
              max: widget.youDistance,
              onChanged: (double value) {
                  setState(() {
                    _progress = value;
                  });
              },
            ),
          ),
        ])
      ],
    );
  }
}

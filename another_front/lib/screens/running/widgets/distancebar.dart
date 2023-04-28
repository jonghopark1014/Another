import 'package:another/constant/color.dart';
import 'package:another/screens/running/widgets/distancebar_custom.dart';
import 'package:flutter/material.dart';

class DistanceBar extends StatefulWidget {
  final String name;
  const DistanceBar({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  State<DistanceBar> createState() => _DistanceBarState(name: name);
}

class _DistanceBarState extends State<DistanceBar> {
  late final String name;
  double _progress = 0.0;

  _DistanceBarState({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: [
          Text(
            name,
            style: TextStyle(
                color: WHITE_COLOR,
                fontWeight: FontWeight.w700,
                fontSize: 14.0),
            textAlign: TextAlign.start,
          ),
          SliderTheme(
            data: SliderThemeData(
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
              value: _progress,
              min: 0,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  _progress = value;
                });
              },
              label: '$_progress',
            ),
          ),
        ])
      ],
    );
  }
}

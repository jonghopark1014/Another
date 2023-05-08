import 'package:another/constant/text_style.dart';
import 'package:flutter/material.dart';

class TargetBox extends StatelessWidget {
  final String name;
  final String data;
  final Color textColor;
  final Color recordColor;

  const TargetBox({
    required this.name,
    required this.data,
    required this.textColor,
    required this.recordColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 80.0,
      child: Column(
        children: [
          SizedBox(
            child: Text(
              '$data',
              style: MyTextStyle.twentyTextStyle.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            '$name',
            style: MyTextStyle.fourteenTextStyle.copyWith(color: recordColor),
          )
        ],
      ),
    );
  }
}

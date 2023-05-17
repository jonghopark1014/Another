import 'package:another_front_wear_os/common/const/color.dart';
import 'package:flutter/material.dart';

class RecordResult extends StatelessWidget {
  final Color recordColor;
  final String data;
  final String name;

  const RecordResult({
    required this.name,
    required this.recordColor,
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          data,
          style: TextStyle(
            color: recordColor,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
        Text(
          name,
          style: const TextStyle(
            color: SERVE_COLOR,
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}

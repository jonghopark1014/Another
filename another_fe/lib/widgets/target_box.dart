import 'package:flutter/material.dart';

class TargetBox extends StatelessWidget {
  final String name;
  final Color textColor;
  final Color recordColor;

  const TargetBox({
    required this.name,
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
              '기록',
              style: TextStyle(
                color: textColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            '${name}',
            style: TextStyle(
              color: recordColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}

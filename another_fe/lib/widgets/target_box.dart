import 'package:flutter/material.dart';

import '../constant/color.dart';

class TargetBox extends StatelessWidget {
  final String name;

  const TargetBox({
    required this.name,
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
                color: MAIN_COLOR,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            '${name}',
            style: TextStyle(
              color: SERVEONE_COLOR,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}

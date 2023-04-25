import 'package:another/widgets/target_box.dart';
import 'package:flutter/material.dart';

import '../constant/color.dart';

class Target extends StatelessWidget {
  final String targetRecord;

  const Target({
    required this.targetRecord,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${targetRecord}',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 20.0,
              fontWeight: FontWeight.w400
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: BLACK_COLOR,
              borderRadius: BorderRadius.circular(20),
            ),
            constraints: BoxConstraints(
              minHeight: 80.0,
              minWidth: 320.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TargetBox(
                  name: 'km',
                ),
                TargetBox(
                  name: '시간',
                ),
                TargetBox(
                  name: 'kacl',
                ),
                TargetBox(
                  name: '평균 페이스',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

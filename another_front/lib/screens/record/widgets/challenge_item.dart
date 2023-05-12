import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';

class ChallengeItem extends StatelessWidget {
  final progress;
  final title;
  final goldBadge;
  final silverBadge;
  ChallengeItem(
      {Key? key,
      required this.title,
      required this.progress,
      required this.goldBadge,
      required this.silverBadge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 200,
      decoration: BoxDecoration(
        color: CONTOUR_COLOR,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: progress >= 1.0
                  ? Image.asset('assets/img/$goldBadge',
                      width: 120, height: 120)
                  : Image.asset('assets/img/$silverBadge',
                      width: 120, height: 120)),
          Text('$title', style: TextStyle(color: SERVEONE_COLOR)),
          SizedBox(height: 10),
          progress >= 1.0
              ? Text('챌린지 뱃지 획득', style: TextStyle(color: SERVETWO_COLOR))
              : Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(MAIN_COLOR),
                  ),
                )
        ],
      ),
    );
  }
}

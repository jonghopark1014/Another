import 'package:another/constant/text_style.dart';
import 'package:another/widgets/target_box.dart';
import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';

class Target extends StatelessWidget {
  final String targetname;
  final String runningDistance;
  final String userCalorie;
  final String runningTime;
  final String userPace;

  const Target({
    required this.targetname,
    required this.runningTime,
    required this.userCalorie,
    required this.runningDistance,
    required this.userPace,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
              width: size.width * 0.95,
              height: size.height * 0.1,
              decoration: BoxDecoration(
                color: BLACK_COLOR,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(minHeight: 80.0, minWidth: 240.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
                    child: Text(
                      targetname,
                      style: TextStyle(color: SERVETWO_COLOR),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TargetBox(
                          data: runningDistance,
                          name: 'km',
                          textColor: MAIN_COLOR,
                          recordColor: SERVEONE_COLOR,
                        ),
                      ),
                      Expanded(
                        child: TargetBox(
                          data: runningTime,
                          name: '시간',
                          textColor: MAIN_COLOR,
                          recordColor: SERVEONE_COLOR,
                        ),
                      ),
                      Expanded(
                        child: TargetBox(
                          data: userCalorie,
                          name: 'kcal',
                          textColor: MAIN_COLOR,
                          recordColor: SERVEONE_COLOR,
                        ),
                      ),
                      Expanded(
                        child: TargetBox(
                          data: userPace,
                          name: '평균 페이스',
                          textColor: MAIN_COLOR,
                          recordColor: SERVEONE_COLOR,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        )
      ],
    );
  }
}

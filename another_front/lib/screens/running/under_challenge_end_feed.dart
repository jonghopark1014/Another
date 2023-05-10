import 'package:another/main.dart';
import 'package:another/screens/running/running_feed_complete.dart';
import 'package:another/widgets/go_back_appbar_style.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../feed/widgets/custom_image.dart';

class UnderChallengeScreenEndFeed extends StatelessWidget {
  final Uint8List? captureInfo;
  UnderChallengeScreenEndFeed({required this.captureInfo, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var runningData = Provider.of<RunningData>(context, listen: false);
    return Scaffold(
      appBar: GoBackAppBarStyle(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: MAIN_COLOR,
                  side: BorderSide(
                    color: MAIN_COLOR,
                    width: 2.5,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CustomImage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_camera_outlined),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                      ),
                      child: Text(
                        '사진 추가하기',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 350.0,
                  child: Image.memory(
                    captureInfo!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Target(
                targetname: '내 기록',
                runningDistance: double.parse(runningData.runningDistance.toStringAsFixed(3)).toString(),
                userCalorie: runningData.userCalories.toString(),
                runningTime: runningData.runningTime,
                userPace: runningData.userPace,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MAIN_COLOR,
                    elevation: 20.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => RunningFeedComplete()),
                        (route) => route.settings.name == '/');
                  },
                  child: Text(
                    '오운완 등록하기',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

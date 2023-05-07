import 'dart:io';
import 'dart:typed_data';
import 'dart:math';

import 'package:another/constant/color.dart';
import 'package:another/main.dart';
import 'package:another/screens/running/api/under_running_api.dart';
import 'package:another/screens/running/under_running_end.dart';
import 'package:another/screens/running/widgets/running_map.dart';
import 'package:another/screens/running/widgets/running_status.dart';
import 'package:flutter/material.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../widgets/record_result.dart';

class UnderRunning extends StatefulWidget {
  UnderRunning({Key? key}) : super(key: key);

  @override
  State<UnderRunning> createState() => _UnderRunningState();
}

class _UnderRunningState extends State<UnderRunning> {
  double runningId = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    print("???????????????????????????");
    // 스크린샷 찍어서 넘겨야 함..
    // ScreenshotController screenshotController = ScreenshotController();
    // Screenshot(
    //   controller: screenshotController,
    //   child: ,
    // );
    super.dispose();
  }

  // getPositionStream 옵션(위치 정확도)
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
  );

  @override
  Widget build(BuildContext context) {
    final runningData = Provider.of<RunningData>(context, listen: false);

    final initialPosition =
        ModalRoute.of(context)!.settings.arguments as CameraPosition;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1/1,
                child: SizedBox(
                    child: RunningMap(runningData: runningData, initialPosition: initialPosition)
                ),
              ),
              // 러닝 중 데이터 출력
              RunningStatus(),
            ],
          ),
        ),
      ),
    );
  }

}

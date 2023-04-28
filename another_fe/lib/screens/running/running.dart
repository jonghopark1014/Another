import 'package:another/screens/running/timer_screen.dart';
import 'package:another/screens/running/widgets/before_running_map.dart';
import 'package:another/screens/running/widgets/running_carousel.dart';
import 'package:another/screens/running/widgets/running_my_history.dart';
import 'package:another/screens/running/widgets/running_setting_button.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunningTab extends StatefulWidget {
  const RunningTab({Key? key}) : super(key: key);

  @override
  State<RunningTab> createState() => _RunningTabState();
}

class _RunningTabState extends State<RunningTab> {

  static CameraPosition initialPosition = CameraPosition(
      target: LatLng(37.523327, 126.921252), zoom: 30
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BeforeRunningMap(CameraPosition(
              target: LatLng(37.523327, 126.921252), zoom: 30
          )),

          Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RunningCarousel(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RunningSettingButton(),
                // RunningCircleButton(iconNamed: Icons.play_arrow, onPressed: onPressed()),
                RunningCircleButton(
                  iconNamed: Icons.play_arrow,
                  onPressed: onPressed,
                ),
                RunningMyHIstoryButton(),
                ],
              ),
            )
          ],
        ),
        ]
      ),
    );
  }
  // 타이머 페이지로 context
  void onPressed() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => TimerScreen(),
            settings: RouteSettings(
              arguments: 'UnderRunning',
            )
        ),
        (route) => false,
    );
  }
}


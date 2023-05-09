import 'package:another/constant/color.dart';
import 'package:another/main.dart';
import 'package:another/screens/running/widgets/running_map.dart';
import 'package:another/screens/running/widgets/running_status.dart';
import 'package:another/screens/running/widgets/set_running_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class UnderRunning extends StatefulWidget {
  UnderRunning({Key? key}) : super(key: key);

  @override
  State<UnderRunning> createState() => _UnderRunningState();
}

class _UnderRunningState extends State<UnderRunning> {
  double runningId = 1;

  late bool isSet;

  @override
  void initState() {
    final settingData = Provider.of<RunningSetting>(context, listen: false);
    print(settingData.distance);
    print(settingData.min);
    print(settingData.interval);
    if (settingData.distance != 0 ||
        settingData.min != 0 ||
        settingData.interval[0] != 0) {
        isSet = true;
    } else {
      isSet = false;
    }
    print('$isSet=====================================================');
    // TODO: implement initState
    super.initState();
  }

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
                aspectRatio: 1 / 1,
                child: SizedBox(
                  child: isSet
                      ? Stack(
                          children: [
                            RunningMap(
                              runningData: runningData,
                              initialPosition: initialPosition,
                            ),
                            // Text('done?????'),
                            SetRunningStatus(),
                          ],
                        )
                      : RunningMap(
                          runningData: runningData,
                          initialPosition: initialPosition,
                        ),
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

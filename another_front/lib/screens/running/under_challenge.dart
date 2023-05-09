import 'package:another/screens/running/api/versus_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:another/main.dart';
import 'package:another/screens/running/widgets/running_map.dart';
import 'package:another/screens/running/widgets/running_status.dart';
import 'package:another/screens/running/widgets/distancebar.dart';

import 'package:another/widgets/target.dart';

class UnderChallenge extends StatefulWidget {
  UnderChallenge({Key? key}) : super(key: key);

  @override
  State<UnderChallenge> createState() => _UnderChallengeState();
}

class _UnderChallengeState extends State<UnderChallenge> {
  double runningId = 1;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final runningData = Provider.of<RunningData>(context, listen: false);
    final initialPosition =
        ModalRoute.of(context)!.settings.arguments as CameraPosition;

    return Scaffold(
      body: Stack(
        children: [
          RunningMap(
              runningData: runningData, initialPosition: initialPosition),
          UnderChallengeStatus(initialPosition: initialPosition),
        ],
      ),
    );
  }
}

class UnderChallengeStatus extends StatefulWidget {
  final CameraPosition initialPosition;
  const UnderChallengeStatus({
    required this.initialPosition,
    Key? key,
  }) : super(key: key);

  @override
  State<UnderChallengeStatus> createState() => _UnderChallengeStatusState();
}

class _UnderChallengeStatusState extends State<UnderChallengeStatus> {
  // 거리
  double runningDistance = 0.0;
  // 상대방 목표 거리
  double challengeDistance = 100.0;

  // 여기에다가 변화는 값 만들어 줘야됨 (시간을 넣어주면됨)
  double _currentSliderValue = 80.0;

  // 상대방
  double _currentYouSliderValue = 60.0;

  @override
  void initState() {
    super.initState();
    _versusApi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _versusApi() async {
    try {
      final response = await VersusApi.getFeed('1');
      print('ddddddd $response');

      setState(
            () {

        },
      );
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 25.0,),
              Target(
                targetname: '목표기록',
                runningDistance: '',
                userCalorie: '',
                runningTime: '',
                userPace: '',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Stack(children: [
                  Column(
                    children: [
                      DistanceBar(
                        name: '상대 페이스',
                        pace: _currentYouSliderValue,
                        youDistance: challengeDistance,
                      ),
                      DistanceBar(
                        name: '내 페이스',
                        pace: _currentSliderValue,
                        youDistance: challengeDistance,
                        distance: runningDistance,
                      ),
                    ],
                  ),
                  Positioned(
                    child: AbsorbPointer(
                      absorbing: true,
                      child: Container(
                        width: 400,
                        height: 150,
                      ),
                    ),
                  ),
                ]),
              ),
              RunningStatus(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:another/constant/color.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:another/screens/running/under_challenge_end.dart';
import 'package:another/screens/running/widgets/distancebar.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:another/widgets/target.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../widgets/record_result.dart';

class UnderChallenge extends StatefulWidget {
  UnderChallenge({Key? key}) : super(key: key);

  static late final List<Marker> markers = [];
  static late final List<LatLng> polyPoints = [];

  @override
  State<UnderChallenge> createState() => _UnderChallengeState();
}

class _UnderChallengeState extends State<UnderChallenge> {
  GoogleMapController? mapController;

  double runningId = 1;

  @override
  void dispose() {
    mapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialPosition = ModalRoute.of(context)!.settings.arguments as CameraPosition;

    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: checkPermission(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data == '위치 권한이 허가 되었습니다.') {
                return StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(),
                  builder: (context, snapshot) {
                    // 위치가 변경되었을 때 실햏하는 로직
                    if (snapshot.data != null && mapController != null) {
                      // 마커 리스트에 추가
                      UnderChallenge.markers.add(Marker(
                        markerId: MarkerId(runningId.toString()),
                        position: LatLng(
                            snapshot.data!.latitude, snapshot.data!.longitude),
                        visible: false,
                      ));
                      runningId += 1;
                      // polypoint(지도에 그리는 점)에 추가
                      UnderChallenge.polyPoints.add(LatLng(
                          snapshot.data!.latitude, snapshot.data!.longitude));
                      // 화면 이동
                      mapController!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(snapshot.data!.latitude,
                                  snapshot.data!.longitude),
                              zoom: 20),
                        ),
                      );
                    }
                    return GoogleMap(
                      initialCameraPosition: initialPosition,
                      mapType: MapType.normal,
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      onMapCreated: onMapCreated,
                      markers: Set.of(UnderChallenge.markers),
                      polylines: Set.of(
                        [
                          Polyline(
                            polylineId: PolylineId('temp'),
                            points: UnderChallenge.polyPoints,
                            color: MAIN_COLOR,
                            // jointType: JointType.round,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return Center(
                child: Text(snapshot.data),
              );
            },
          ),
          // 러닝 중 데이터 출력
          UnderChallengeStatus(initialPosition: initialPosition),
        ],
      ),
    );
  }

  // 맵컨트롤러 받기 => 지도 카메라 위치 조정시 필요
  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // 사용자에게 위치 동의 구하기 단계별로
  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요';
    }
    LocationPermission checkedPermission = await Geolocator.checkPermission();
    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();
      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }
    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 세팅에서 허가해주세요';
    }
    return '위치 권한이 허가 되었습니다.';
  }
}



class UnderChallengeStatus extends StatefulWidget {
  final CameraPosition initialPosition;
  const UnderChallengeStatus({
    required this.initialPosition,
    Key? key
  }) : super(key: key);

  @override
  State<UnderChallengeStatus> createState() => _UnderChallengeStatusState();
}

class _UnderChallengeStatusState extends State<UnderChallengeStatus> {
  // 페이스
  String userPace = "0'00''";
  // 시작 시간
  DateTime startTime = DateTime.now();
  // 거리
  double runningDistance = 0;
  late Position currentPosition;
  late Position beforePosition = Position(
    longitude: widget.initialPosition.target.longitude,
    latitude: widget.initialPosition.target.latitude,
    accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0, timestamp: startTime,
  );
  // 시간
  late Timer _timer;

  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  String timeResult = '00:00:00';

  // 여기에다가 변화는 값 만들어 줘야됨
  double _currentSliderValue = 80.0;
  late bool isStart;
  // 비동기로 거리 받아서 계산
  Future setDistance() async {
    currentPosition = await Geolocator.getCurrentPosition();
    if (isStart) {
      runningDistance += Geolocator.distanceBetween(
        beforePosition.latitude,
        beforePosition.longitude,
        currentPosition.latitude,
        currentPosition.longitude,
      ).round();
    }
    // 갱신
    beforePosition = currentPosition;
  }
  // 페이스 계산 -> 1km을 도달하는 시간
  void paceCal() {
    double timeToSec = (hours * 3600 + minutes * 60 + seconds).toDouble();
    int paceBase = (timeToSec / runningDistance * 1000).toInt();
    int paceMin = paceBase ~/ 60;
    int paceSec = paceBase % 60;
    userPace = "${paceMin.toString()}'${paceSec.toString()}''";
  }
  // 상대방
  double _currentYouSliderValue = 60.0;

  @override
  void initState() {
    super.initState();
    isStart = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setDistance();
      setState(() {
        if (isStart) {
          seconds++;
          if (seconds == 60) {
            minutes += 1;
            seconds = 0;
          } else if (minutes == 60) {
            hours += 1;
            minutes = 0;
          }
          paceCal();
        }
        timeResult =
            '${hours.toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Target(targetname: '목표기록'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Stack(children: [
                    Column(
                      children: [
                        DistanceBar(
                          name: '상대 페이스',
                          pace: _currentYouSliderValue,
                        ),
                        DistanceBar(
                          name: '내 페이스',
                          pace: _currentSliderValue,
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
                RecordResult(
                  timer:
                  '${hours.toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}',
                  distance: '0',
                  calories: '0',
                  pace: userPace,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // RunningCircleButton(iconNamed: Icons.play_arrow,onPressed: ,),
                      isStart
                          ? RunningCircleButton(
                        iconNamed: Icons.pause,
                        onPressed: onPause,
                      )
                          : RunningCircleButton(
                        iconNamed: Icons.play_arrow,
                        onPressed: onStart,
                      ),
                      GestureDetector(
                        onLongPress: () {
                          onStop();
                        },
                        child: RunningCircleButton(
                          iconNamed: Icons.stop,
                          onPressed: onChange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onStart() {
    setState(() {
      isStart = !isStart;
    });
  }

  void onPause() {
    setState(() {
      isStart = !isStart;
    });
  }

  void onStop() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (_) => UnderChallengeScreenEnd(),
        ),
            (route) => route.settings.name == '/');
  }
  void onChange() {}
}


import 'package:another/constant/color.dart';
import 'package:another/screens/running/under_running_end.dart';
import 'package:flutter/material.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'dart:async';

import '../../widgets/record_result.dart';

class UnderRunning extends StatelessWidget {
  UnderRunning({Key? key}) : super(key: key);

  // 지도에 위치 그리기
  GoogleMapController? mapController;
  // static CameraPosition initialPosition =
      // CameraPosition(target: LatLng(37.523327, 126.921252), zoom: 30);
  static late final List<Marker> markers = [];
  static late final List<LatLng> polyPoints = [];
  double runningDistance = 0;
  LatLng beforeLatLng = LatLng(36.3600, 127.3448);
  LatLng nowLatLng = LatLng(36.3600, 127.3448);
  double runningId = 1;

  // 거리 계산하는 메서드
  void _distanceCal(LatLng start, LatLng end) {

    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((end.latitude - start.latitude) * p) / 2 +
        cos(start.latitude * p) * cos(end.latitude * p) *
            (1 - cos((end.longitude - start.longitude) * p))/2;
    runningDistance += (12742 * asin(sqrt(a))).round();
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
                      // 거리 계산
                      nowLatLng = LatLng(
                          snapshot.data!.latitude, snapshot.data!.longitude);
                      _distanceCal(beforeLatLng, nowLatLng);
                      beforeLatLng = nowLatLng;
                      // 마커 리스트에 추가
                      markers.add(Marker(
                        markerId: MarkerId(runningId.toString()),
                        position: LatLng(
                            snapshot.data!.latitude, snapshot.data!.longitude),
                        visible: false,
                      ));
                      runningId += 1;
                      // polypoint(지도에 그리는 점)에 추가
                      polyPoints.add(LatLng(
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
                      markers: Set.of(markers),
                      polylines: Set.of(
                        [
                          Polyline(
                            polylineId: PolylineId('temp'),
                            points: polyPoints,
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
          UnderRunningStatus(initialPosition: initialPosition),
        ],
      ),
    );
  }



  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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
// 지도를 매번 setState로 매초 다시 그리면 터짐
// 그래서 따로 뺌
class UnderRunningStatus extends StatefulWidget {
  final CameraPosition initialPosition;
  const UnderRunningStatus({
    required this.initialPosition,
    Key? key
  }) : super(key: key);

  @override
  State<UnderRunningStatus> createState() => _UnderRunningStatusState();
}

class _UnderRunningStatusState extends State<UnderRunningStatus> {
  // 거리
  double runningDistance = 0;
  late Position currentPosition;
  late Position beforePosition = Position(
    longitude: widget.initialPosition.target.longitude,
    latitude: widget.initialPosition.target.latitude,
    accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0, timestamp: DateTime(hours),
  );
  // 시간
  late Timer _timer;

  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  bool isStart = false;
  // 비동기로 거리 받아서 계산
  Future setDistance() async {
    currentPosition = await Geolocator.getCurrentPosition();
    if (isStart == false) {
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

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        setDistance();
        seconds++;
        if (seconds == 60) {
          minutes += 1;
          seconds = 0;
        } else if (minutes == 60) {
          hours += 1;
          minutes = 0;
        }
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
    return // 달릴 때 데이터 표시
      Container(
        color: BACKGROUND_COLOR,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 282,
                  ),
                  RecordResult(
                    timer:
                    '${hours.toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}',
                    distance: runningDistance.toString(),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // RunningCircleButton(iconNamed: Icons.play_arrow,onPressed: ,),
                        isStart
                            ? RunningCircleButton(
                          iconNamed: Icons.play_arrow,
                          onPressed: onStart,
                        )
                            : RunningCircleButton(
                          iconNamed: Icons.pause,
                          onPressed: onPause,
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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        setDistance();
        isStart = false;
        seconds++;
        if (seconds == 60) {
          minutes += 1;
          seconds = 0;
        } else if (minutes == 60) {
          hours += 1;
          minutes = 0;
        }
      });
    });
  }

  void onPause() {
    setState(() {
      isStart = !isStart;
    });
    _timer?.cancel();
  }

  void onStop() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => UnderRunningScreenEnd(),
        ),
            (route) => false);
  }
  void onChange() {}
}

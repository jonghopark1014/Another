import 'package:another/constant/color.dart';
import 'package:another/screens/running/under_running_end.dart';
import 'package:flutter/material.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import '../../widgets/record_result.dart';

class UnderRunning extends StatelessWidget {
  UnderRunning({Key? key}) : super(key: key);

  // 지도에 위치 그리기
  GoogleMapController? mapController;
  static late final List<Marker> markers = [];
  static late final List<LatLng> polyPoints = [];
  double runningId = 1;
  
  @override
  void dispose() {
    // 스크린샷 찍어서 넘겨야 함.. 라우팅도.. 여기서 해야할듯?
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
  // 시간초는 거리 갱신할때도 쓰면 좋아서 그대로 흘러감 
  // 대신 저장의 유무를 정지, 시작의 상태에 따라서 저장
  @override
  void initState() {
    super.initState();
    isStart = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        setDistance();
        if (isStart) {
          seconds++;
          if (seconds == 60) {
            minutes += 1;
            seconds = 0;
          } else if (minutes == 60) {
            hours += 1;
            minutes = 0;
          }
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
  // 시작 버튼을 누르면 동작 => 시간 갱신 시작
  void onStart() {
    setState(() {
      isStart = !isStart;
    });
  }
  // 정지 버튼을 누르면 동작 => 시간 갱신 정지
  void onPause() {
    setState(() {
      isStart = !isStart;
    });
    // _timer?.cancel();
  }
  // 러닝 종료 시 동작
  void onStop() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => UnderRunningScreenEnd(),
        ),
            (route) => false);
  }
  void onChange() {}
}

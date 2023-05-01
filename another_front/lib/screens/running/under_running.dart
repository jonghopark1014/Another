import 'package:another/constant/color.dart';
import 'package:another/screens/running/under_running_end.dart';
import 'package:flutter/material.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import '../../widgets/record_result.dart';

class UnderRunning extends StatefulWidget {
  const UnderRunning({Key? key}) : super(key: key);

  @override
  State<UnderRunning> createState() => _UnderRunningState();
}

class _UnderRunningState extends State<UnderRunning> {
  late Timer _timer;

  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  bool isStart = false;
  double runningId = 1;
  // 지도에 위치 그리기
  GoogleMapController? mapController;
  static CameraPosition initialPosition =
      CameraPosition(target: LatLng(37.523327, 126.921252), zoom: 30);

  static late final List<Marker> markers = [];

  static late final List<LatLng> polyPoints = [];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
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
                    print(snapshot.data);
                    if (snapshot.data != null && mapController != null) {
                      markers.add(Marker(
                        markerId: MarkerId(runningId.toString()),
                        position: LatLng(
                            snapshot.data!.latitude, snapshot.data!.longitude),
                        visible: false,
                      ));
                      runningId += 1;
                      polyPoints.add(LatLng(
                          snapshot.data!.latitude, snapshot.data!.longitude));
                      mapController!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(snapshot.data!.latitude,
                                  snapshot.data!.longitude),
                              zoom: 20),
                        ),
                      );
                    }
                    print(
                        '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
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
                      RecordResult(timer:
                      '${hours.toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}',),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // RunningCircleButton(iconNamed: Icons.play_arrow,onPressed: ,),
                            isStart
                                ? RunningCircleButton(
                              iconNamed: Icons.play_arrow,
                              onPressed: onPause,
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
          ),
        ],
      ),
    );
  }

  void onStart() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
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

  void onChange() {

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

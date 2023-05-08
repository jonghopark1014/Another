import 'package:another/constant/color.dart';
import 'package:another/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class RunningMap extends StatefulWidget {
  final RunningData runningData;
  final CameraPosition initialPosition;
  const RunningMap({
    required this.runningData,
    required this.initialPosition,
    Key? key
  }) : super(key: key);

  @override
  State<RunningMap> createState() => _RunningMapState();
}

class _RunningMapState extends State<RunningMap> {
  // 지도에 위치 그리기
  GoogleMapController? mapController;
// 캡처를 위한 키
  final GlobalKey _globalKey = GlobalKey();

  @override
  void dispose() {
    mapController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkPermission(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == '위치 권한이 허가 되었습니다.') {
          print("돌았다");
          return RepaintBoundary(
            key: _globalKey,
            child: StreamBuilder<Position>(
              stream: Geolocator.getPositionStream(),
              builder: (context, snapshot) {
                // 위치가 변경되었을 때 실햏하는 로직
                if (snapshot.data != null && mapController != null) {
                  if (snapshot.data!.latitude != widget.runningData.curValue.latitude && snapshot.data!.latitude != widget.runningData.curValue.longitude) {
                    LatLng pos = LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
                    // polypoint(지도에 그리는 점)에 추가
                    widget.runningData.addLocation(pos);
                  }
                  // 화면 이동
                  mapController!.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(snapshot.data!.latitude,
                              snapshot.data!.longitude),
                          zoom: 18),
                    ),
                  );
                }
                return GoogleMap(
                  initialCameraPosition: widget.initialPosition,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onMapCreated: onMapCreated,
                  polylines: {
                    Polyline(
                      polylineId: PolylineId('temp'),
                      points: widget.runningData.location,
                      color: MAIN_COLOR,
                      // jointType: JointType.round,
                    ),
                  },
                );
              },
            ),
          );
        }
        return Center(
          child: Text(snapshot.data),
        );
      },
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





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
  // 지도관련
  GoogleMapController? mapController;
  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요';
    }
    LocationPermission checkedPermission = await Geolocator.checkPermission();
    if(checkedPermission == LocationPermission.denied){
      checkedPermission = await Geolocator.requestPermission();
      if(checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }
    if(checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 세팅에서 허가해주세요';
    }
    // 위치 권한 완료
    return '위치 권한이 허가 되었습니다.';
  }

  static CameraPosition initialPosition = CameraPosition(
      target: LatLng(37.523327, 126.921252), zoom: 20
  );
  static CameraPosition userPosition = initialPosition;

  @override
  void dispose() {
    mapController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // 러닝중 지도 ====================================================
            FutureBuilder(
              future: checkPermission(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()
                  );
                }
                if(snapshot.data == '위치 권한이 허가 되었습니다.'){
                  return StreamBuilder<Position>(
                    stream: Geolocator.getPositionStream(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null && mapController != null) {
                        // 러닝중 초기 위치를 위해
                        userPosition = CameraPosition(
                            target: LatLng(
                                snapshot.data!.latitude, snapshot.data!.longitude
                            ), zoom: 20
                        );
                        // 지도를 이동된 위치에 맞춤
                        mapController!.animateCamera(CameraUpdate.newCameraPosition(
                            CameraPosition(
                                target: LatLng(
                                    snapshot.data!.latitude, snapshot.data!.longitude
                                ), zoom: 20
                            )
                        ));
                      }
                      return GoogleMap(
                        initialCameraPosition: initialPosition,
                        mapType: MapType.normal,
                        zoomControlsEnabled: false,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        onMapCreated: onMapCreated,
                      );
                    },
                  );
                }
                return Center(
                  child: Text(snapshot.data),
                );
              },
            ),
            // 러닝 전 화면 =============================
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
      ),
    );
  }
  // 타이머 페이지로 context
  void onPressed() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => TimerScreen(
              path: '/UnderRunning',
              initialPosition: userPosition,
            ),
        ),
        (route) => route.settings.name == '/',
    );
  }
}


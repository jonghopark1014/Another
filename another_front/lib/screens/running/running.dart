import 'package:another/constant/color.dart';
import 'package:another/screens/running/timer_screen.dart';
import 'package:another/screens/running/widgets/before_running_map.dart';
import 'package:another/screens/running/widgets/running_carousel.dart';
import 'package:another/screens/running/widgets/running_my_history.dart';
import 'package:another/screens/running/widgets/running_small_button.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:another/widgets/target.dart';
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
    // 위치 정보 권한 요청
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
    // 위치 권한 완료
    return '위치 권한이 허가 되었습니다.';
  }

  static CameraPosition initialPosition =
      CameraPosition(target: LatLng(37.523327, 126.921252), zoom: 20);
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
        body: Stack(children: [
          // 러닝중 지도 ====================================================
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
                    if (snapshot.data != null && mapController != null) {
                      // 러닝중 초기 위치를 위해
                      userPosition = CameraPosition(
                          target: LatLng(snapshot.data!.latitude,
                              snapshot.data!.longitude),
                          zoom: 20);
                      // 지도를 이동된 위치에 맞춤
                      mapController!.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target: LatLng(snapshot.data!.latitude,
                                  snapshot.data!.longitude),
                              zoom: 20)));
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
                    RunningSmallButton(
                      iconNamed: Icons.settings,
                      onPressed: toSetting,
                    ),
                    // RunningCircleButton(iconNamed: Icons.play_arrow, onPressed: onPressed()),
                    RunningCircleButton(
                      iconNamed: Icons.play_arrow,
                      onPressed: onPressed,
                    ),
                    RunningSmallButton(
                      iconNamed: Icons.list,
                      onPressed: toHistory,
                    ),
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }

  // 세팅 페이지로
  Future<dynamic> toSetting() {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: BACKGROUND_COLOR,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            height: 280,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(
                        color: CONTOUR_COLOR,
                      ))
                    ),
                    child: Text(
                      '목표설정',
                      style: TextStyle(
                        color: SERVETWO_COLOR,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SettingName(typeName: '거리(km)'),
                      SettingContent(content: '거리 목표를 설정해주세요'),
                    ],
                  ),
                  Row(
                    children: [
                      SettingName(typeName: '시간(분)'),
                      SettingContent(content: '시간을 설정해주세요'),
                    ],
                  ),
                  Row(
                    children: [
                      SettingName(typeName: '인터벌'),
                      SettingContent(content: '러닝시간과 걷기 시간을 설정해주세요'),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      primary: MAIN_COLOR,
                    ),
                    child: const Text(
                        '러닝 시작!',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    // 나중에 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!
                    onPressed: onPressed,
                  ),
                ],
              ),
            ),
          );
        });
  }

  // 최근기록 페이지로
  Future<dynamic> toHistory() {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: BACKGROUND_COLOR,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            height: 1000,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    child: Center(
                      child: Text(
                        '최근에 내가 달린 기록',
                        style: TextStyle(
                          color: WHITE_COLOR,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: MyHistory(historyList: ['1', '2'])
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      primary: MAIN_COLOR,
                    ),
                    child: const Text(
                      '러닝 시작!',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    // 나중에 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!
                    onPressed: onPressed,
                  ),
                ],
              ),
            ),
          );
        });
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

class MyHistory extends StatelessWidget {
  final List<dynamic> historyList;
  const MyHistory({
    required this.historyList,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: historyList.length,
        itemBuilder: (BuildContext context, int index) {
          return Target(targetname: '날짜');
        }
    );
  }
}


// 세팅 내용 처리
class SettingContent extends StatelessWidget {
  final String content;
  const SettingContent({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
        content,
        style: TextStyle(
          fontSize: 18,
          color: SERVETWO_COLOR,
        ),
    );
  }
}

// 세팅 종류
class SettingName extends StatelessWidget {
  final String typeName;
  const SettingName({
    required this.typeName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Text(
          typeName,
        style: TextStyle(
          color: SERVEONE_COLOR,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

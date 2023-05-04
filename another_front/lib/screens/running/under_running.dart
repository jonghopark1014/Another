import 'dart:io';
import 'dart:typed_data';
import 'dart:math';

import 'package:another/constant/color.dart';
import 'package:another/main.dart';
import 'package:another/screens/running/api/under_running_api.dart';
import 'package:another/screens/running/under_running_end.dart';
import 'package:flutter/material.dart';
import 'package:another/screens/running/widgets/running_circle_button.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../widgets/record_result.dart';

class UnderRunning extends StatefulWidget {
  UnderRunning({Key? key}) : super(key: key);

  @override
  State<UnderRunning> createState() => _UnderRunningState();
}

class _UnderRunningState extends State<UnderRunning> {
  // 캡처를 위한 키
  final GlobalKey _globalKey = GlobalKey();
  // 지도에 위치 그리기
  GoogleMapController? mapController;
  double runningId = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _captureWidget();
    mapController!.dispose();
    print("???????????????????????????");
    // 스크린샷 찍어서 넘겨야 함..
    // ScreenshotController screenshotController = ScreenshotController();
    // Screenshot(
    //   controller: screenshotController,
    //   child: ,
    // );
    super.dispose();
  }

  // getPositionStream 옵션(위치 정확도)
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
  );

  @override
  Widget build(BuildContext context) {
    final runningData = Provider.of<RunningData>(context, listen: false);

    final initialPosition =
        ModalRoute.of(context)!.settings.arguments as CameraPosition;

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
                print("돌았다");
                return RepaintBoundary(
                  key: _globalKey,
                  child: StreamBuilder<Position>(
                    stream: Geolocator.getPositionStream(locationSettings: locationSettings),
                    builder: (context, snapshot) {
                      // 위치가 변경되었을 때 실햏하는 로직
                      if (snapshot.data != null && mapController != null) {
                        if (snapshot.data!.latitude != runningData.curValue.latitude && snapshot.data!.latitude != runningData.curValue.longitude) {
                          LatLng pos = LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
                          // polypoint(지도에 그리는 점)에 추가
                          runningData.addLocation(pos);
                        }
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
                        polylines: {
                          Polyline(
                            polylineId: PolylineId('temp'),
                            points: runningData.location,
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
          ),
          // 러닝 중 데이터 출력
          UnderRunningStatus(initialPosition: initialPosition),
        ],
      ),
    );
  }

  // 캡처하기
  void _captureWidget() async {
    // try {
    //   RenderRepaintBoundary? boundary =
    //   _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    //   ui.Image image = await boundary.toImage(pixelRatio: 5.0); // 해상도
    //   ByteData? byteData =
    //   await image.toByteData(format: ui.ImageByteFormat.png);
    //   final listBytes = byteData!.buffer.asUint8List();
    //     // TODO: 캡처된 이미지를 저장 또는 사용합니다.
    //   final file = File('example.png');
    //   await file.writeAsBytes(listBytes);
    // } catch (e) {
    //   print(e);
    // }
    Uint8List imgByte = await mapController!.takeSnapshot() as Uint8List;
    final file = File('example.png');
    await file.writeAsBytes(imgByte);
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
  const UnderRunningStatus({required this.initialPosition, Key? key})
      : super(key: key);

  @override
  State<UnderRunningStatus> createState() => _UnderRunningStatusState();
}

class _UnderRunningStatusState extends State<UnderRunningStatus> {

  int _userWeight = 0;
  String runDataId = '0';
  final int timeInterval = 5;
  // 칼로리
  int userCalories = 0;
  // 페이스
  String userPace = "0'00''";
  // 시작 시간
  DateTime startTime = DateTime.now();
  // 거리
  double runningDistance = 0;
  // late Position currentPosition;
  // late Position beforePosition = Position(
  //   longitude: widget.initialPosition.target.longitude,
  //   latitude: widget.initialPosition.target.latitude,
  //   accuracy: 0,
  //   altitude: 0,
  //   heading: 0,
  //   speed: 0,
  //   speedAccuracy: 0,
  //   timestamp: startTime,
  // );
  // 시간
  String runningTime = '00:00:00';
  late Timer _timer;

  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  late bool isStart;

  // 페이스 계산 -> 1km을 도달하는 시간
  void setData() {
    final runningData = Provider.of<RunningData>(context, listen: false);
    // print("---------------before------------");
    // print(runningData.curValue);
    // print(runningData.callLoc());
    // print("---------------after------------");
    // runningData.changeLoc(runningData.callLoc());
    // print(runningData.preValue);
    // print(runningData.curValue);

    // 거리 계산
    double nowDistance = runningData.runningDistance;
    LatLng past = runningData.preValue;
    LatLng current = runningData.curValue;

    // 러닝 시간
    runningTime =
    '${hours.toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
    runningData.setTime(runningTime);
    print("======================================");
    print(runningData.runningTime);
    print(runningData.location);


    if (runningData.location.length > 1) {
      nowDistance += 2 *
          6371 *
          asin(sqrt(
              pow(sin((current.latitude - past.latitude) / 2 * pi / 180), 2) +
                  cos(past.latitude * pi / 180) *
                      cos(current.latitude * pi / 180) *
                      pow(
                          sin((current.longitude - past.longitude) /
                              2 *
                              pi /
                              180),
                          2)));
      runningData.setDistance(nowDistance);
      runningDistance = double.parse(nowDistance.toStringAsFixed(1));


      // 페이스 계산
      double timeToSec = (hours * 3600 + minutes * 60 + seconds).toDouble();
      int paceBase = 0;
      if (runningDistance != 0) {
        paceBase = (timeToSec ~/ runningDistance);
      }
      int paceMin = paceBase ~/ 60;
      int paceSec = paceBase % 60;
      userPace = "${paceMin.toString()}'${paceSec.toString()}''";
      runningData.setPace(userPace);

      // 칼로리 계산
      userCalories = (_userWeight * runningDistance * 1.036 ~/ 1);
      runningData.setCalories(userCalories);

      Kafka.sendTopic(latitude: current.latitude, longitude: current.longitude, runningId: runDataId, runningDistance: runningDistance, runningTime: runningTime, userCalories: userCalories, userPace: userPace);
    }
  }

  // 시간초는 거리 갱신할때도 쓰면 좋아서 그대로 흘러감
  // 대신 저장의 유무를 정지, 시작의 상태에 따라서 저장
  @override
  void initState() {
    super.initState();
    // 유저 정보 받아오기
    final userInfo = context.read<UserInfo>();
    _userWeight = userInfo.weight;
    String userId = userInfo.userId.toString();
    String forRunId1 = DateFormat('yyMMddHHmmss').format(DateTime.now());
    runDataId = userId + forRunId1;
    // 타이머 시작
    isStart = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
          setData();
        }
      });
    });
  }

  @override
  void dispose() {
    print('timer cancel=====================================');
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
                  timer: runningTime,
                  distance: runningDistance.toString(),
                  calories: userCalories.toString(),
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

  // 시작 버튼을 누르면 동작 => 시간 갱신 시작
  void onStart() {
    setState(() {
      isStart = true;
    });
  }

  // 정지 버튼을 누르면 동작 => 시간 갱신 정지
  void onPause() {
    setState(() {
      isStart = false;
    });
    // _timer?.cancel();
    
  }

  // 러닝 종료 시 동작
  void onStop() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => UnderRunningScreenEnd(),
        ),
        (route) => route.settings.name == '/');
  }

  void onChange() {}
}

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:another/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

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
  bool flag = false;
  int stopCount = -1;

  late Uint8List? img;
  late Timer _timer;
  // 지도에 위치 그리기
  GoogleMapController? mapController;
  late CameraPosition currentPosition;
  // 맵컨트롤러 받기 => 지도 카메라 위치 조정시 필요
  onMapCreated(GoogleMapController controller) {
    mapController = controller;
    var runningData = Provider.of<RunningData>(context, listen: false);
    runningData.setMapController(mapController!);
    mapController?.setMapStyle(
        '''[
          {"featureType": "administrative.land_parcel", "elementType": "labels", "stylers": [{"visibility": "off"}]},
          {"featureType": "poi", "elementType": "labels.text", "stylers": [{"visibility": "off"}]},
          {"featureType": "poi", "elementType": "labels.icon", "stylers": [{"visibility": "off"}]},
          {"featureType": "poi.business", "stylers": [{"visibility": "off"}]},
          {"featureType": "road", "elementType": "labels.icon", "stylers": [{"visibility": "off"}]},
          {"featureType": "road", "elementType": "labels", "stylers": [{"visibility": "off"}]},
          {"featureType": "road.local", "elementType": "labels", "stylers": [{"visibility": "off"}]},
          {"featureType": "transit", "stylers": [{"visibility": "off"}]},
        ]'''
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPosition = widget.initialPosition;
    Provider.of<RunningData>(context, listen: false).newPolyLine(currentPosition.target, 0);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      getCurrentLocation();
    });
  }
  @override
  void dispose() async {
    print("내가바로 dispose!_map!");
    super.dispose();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return
        GoogleMap(
        rotateGesturesEnabled: false,
        scrollGesturesEnabled: false,
        tiltGesturesEnabled: false,
        initialCameraPosition: currentPosition,
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: onMapCreated,
        polylines: Set<Polyline>.of(Provider.of<RunningData>(context, listen: true).polyLine),
        );
  }
  void forPolyList(LatLng latLng) {
    var runFunc = Provider.of<RunningData>(context, listen: false);
    stopCount = runFunc.stopCount;
    print(stopCount);
    if (stopCount == runFunc.polyLine.length) {
      runFunc.newPolyLine(latLng, stopCount);
    }

    else if (stopCount < runFunc.polyLine.length) {
      runFunc.addPolyLine(stopCount, latLng);
    }
  }

  void getCurrentLocation() async {
    // 위치 정보 권한 요청
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return ;
    }
    LocationPermission checkedPermission = await Geolocator.checkPermission();
    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();
      if (checkedPermission == LocationPermission.denied) {
        return ;
      }
    }
    if (checkedPermission == LocationPermission.deniedForever) {
      return ;
    }
    // 위치 권한 완료
    if (mounted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      changeCamera(position);
    }
    return ;
  }
  double _toRadians(double degrees) {
    return degrees * pi / 180;
  }

  double distanceFunc(past, current) {
    // 거리 계산
    // // 기준점 변경

    // // 지구 반지름
    double earth = 6371;

    // // 기준점 2개(현재, 과거)에 대한 latRad, LonRad
    double lat1Rad = _toRadians(past.latitude);
    double lat2Rad = _toRadians(current.latitude);
    double lon1Rad = _toRadians(past.longitude);
    double lon2Rad = _toRadians(current.longitude);

    // // 기준점 2개에 대한 delta값
    double deltaLat = lat2Rad - lat1Rad;
    double deltaLon = lon2Rad - lon1Rad;

    // // 위도, 경도에 따른 거리 구하기
    final a = pow(sin(deltaLat / 2), 2) +
        cos(lat1Rad) *
            cos(lat2Rad) *
            pow(sin(deltaLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earth * c;
  }

  void changeCamera(Position position) {
    var runningData = Provider.of<RunningData>(context, listen: false);
    if (position.latitude != runningData.curValue.latitude && position.longitude != runningData.curValue.longitude && mapController != null) {
      runningData.setLat(position.latitude);
      runningData.setLng(position.longitude);
      runningData.setCurrentPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 17));
      if (Provider.of<RunningData>(context, listen: false).stopFlag == false) {
          setState(() {
            forPolyList(LatLng(position.latitude, position.longitude));
          });
        }
        mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 17)));
      }
      runningData.addLocation(LatLng(position.latitude, position.longitude), 0);
      
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

import 'dart:async';

import 'package:another/main.dart';
import 'package:another/widgets/get_permission.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class BeforeRunningMap extends StatefulWidget {
  const BeforeRunningMap({Key? key}) : super(key: key);

  @override
  State<BeforeRunningMap> createState() => _BeforeRunningMapState();
}

class _BeforeRunningMapState extends State<BeforeRunningMap> {
  late Timer _timer;
  // 지도관련
  GoogleMapController? mapController;
  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  bool isLoading = false;
  static late CameraPosition currentPosition;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      getCurrentLocation();
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
      isLoading ? GoogleMap(
      initialCameraPosition: currentPosition,
      mapType: MapType.normal,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: onMapCreated,
    ) : Center(child: CircularProgressIndicator());
  }
  void getCurrentLocation() async {

    // 권한 확인 및 요청 (복붙) =====================================
    bool permissionStatus = await getPermission();
    if (permissionStatus == false) {
      return;
    }
    // 권한 확인 후 로직 ===========================================

    // 위치 권한 완료 후 로직
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 17);
      Provider.of<RunningData>(context, listen: false).setCurrentPosition(currentPosition);
      isLoading = true;
      if (mapController != null ) {
        mapController!.animateCamera(
            CameraUpdate.newCameraPosition(currentPosition)
        );
      }

    });
    return ;
  }
}

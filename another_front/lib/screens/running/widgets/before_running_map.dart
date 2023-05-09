import 'dart:async';

import 'package:another/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    print("지도 controller 및 onMapCreated");
    mapController = controller;
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
  bool isLoading = false;
  static late CameraPosition currentPosition;

  @override
  void initState() {
    print("initstate");
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      getCurrentLocation();
    });
  }
  @override
  void dispose() {
    print("dispose");
    mapController!.dispose();
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("build");
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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      print("setState");
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

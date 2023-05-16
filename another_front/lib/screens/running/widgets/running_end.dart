import 'dart:async';
import 'dart:typed_data';

import 'package:another/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

class EndRunningMap extends StatefulWidget {
  const EndRunningMap({Key? key}) : super(key: key);

  @override
  State<EndRunningMap> createState() => _EndRunningMapState();
}

class _EndRunningMapState extends State<EndRunningMap> {

  int isCap = 0;
  bool isFalse = false;
  GoogleMapController? mapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() async {
    mapController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("결과 맵 rebuild");
    return Stack(
        children: [
          GoogleMap(
            initialCameraPosition: Provider.of<RunningData>(context, listen: false).currentPosition,
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: false,
            tiltGesturesEnabled: false,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            onMapCreated: _onMapCreated,
            onCameraIdle: _onMapIdle,
            polylines: Set<Polyline>.of(Provider.of<RunningData>(context, listen: false).polyLine),
          ),
        ]
    );
  }
  void _onMapIdle() {
    var runningData = Provider.of<RunningData>(context, listen: false);
    LatLngBounds bound = LatLngBounds(southwest: LatLng(runningData.minLat, runningData.minLng), northeast: LatLng(runningData.maxLat, runningData.maxLng));
    if (mounted && isCap != 3) {
      isCap++;
      Future.delayed(Duration(milliseconds: 500), () {
        print("나왔당");
        mapController?.animateCamera(CameraUpdate.newLatLngBounds(bound, 50));
      });
      Future.delayed(Duration(milliseconds: 500), () async {
        Uint8List? runPic = await captureWidget();
        runningData.setRunningPic(runPic);
        print("찍었당");
      });
    }
  }

  Future<Uint8List?> captureWidget() async {
    final Uint8List? bytes = await mapController!.takeSnapshot();
    return bytes;
  }

  // 지도에 위치 그리기
  // 맵컨트롤러 받기 => 지도 카메라 위치 조정시 필요
  _onMapCreated(GoogleMapController controller) {
    print("onMapCreated!");
    mapController = controller;
    mapController!.setMapStyle(
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
}

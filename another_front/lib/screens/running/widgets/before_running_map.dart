import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

FutureBuilder<String> beforeRunningMap(CameraPosition initialPosition) {
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

    return '위치 권한이 허가 되었습니다.';
  }

  return FutureBuilder(
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
              print(snapshot.data!.latitude);
              print('==========================================');
              mapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(
                          snapshot.data!.latitude, snapshot.data!.longitude
                      ), zoom: 30
                  )
              ));
            }
            print(snapshot.data);
            print(mapController);
            print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
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
  );
}

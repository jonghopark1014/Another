import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> getPermission() async {
  // 일반 위치 권한 요청
  PermissionStatus locationStatus = await Permission.location.request();
  if (locationStatus == PermissionStatus.denied) {
    return false;
  }
  // 일반 위치 권한이 허용된 경우
  // 백그라운드 위치 권한 요청
  PermissionStatus backgroundStatus = await Permission.locationAlways.request();
  if (backgroundStatus == PermissionStatus.denied) {
    return false;
  }
  // 사진 권한 요청
  PermissionStatus photoStatus = await Permission.photos.request();
  if (photoStatus == PermissionStatus.denied) {
    return false;
  }
  return true;
}
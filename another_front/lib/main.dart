import 'dart:typed_data';

import 'package:another/constant/color.dart';
import 'package:another/screens/home_screen.dart';
import 'package:another/screens/running/challenge_running.dart';
import 'package:another/screens/running/running.dart';
import 'package:another/screens/running/under_challenge.dart';
import 'package:another/screens/running/under_running.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class RunningData extends ChangeNotifier {
  late GoogleMapController mapController;
  CameraPosition currentPosition = CameraPosition(target: LatLng(0,0), zoom: 17);
  String runningId = '';
  List<LatLng> location = [];
  LatLng preValue = LatLng(0, 0);
  LatLng curValue = LatLng(0, 0);
  String runningTime = '00:00:00';
  double runningDistance = 0;
  int userCalories = 0;
  String userPace = "0'00''";
  int preLen = 0;
  var runningPic;
  double minLat = 24.5;
  double minLng = -124.8;
  double maxLat = 49.5;
  double maxLng = -66.95;

  void reset() {
    location = [];
    preValue = LatLng(0, 0);
    curValue = LatLng(0, 0);
    runningTime = '00:00:00';
    runningDistance = 0;
    userCalories = 0;
    userPace = "0'00''";
    preLen = 1;
  }

  void setRunningId(value) {
    runningId = value;
  }

  void setTime(String time) {
    runningTime = time;
    notifyListeners();
  }
  void setDistance(double dis) {
    runningDistance = dis;
    notifyListeners();
  }
  void setCalories(int cal) {
    userCalories= cal;
    notifyListeners();
  }
  void setPace(String pace) {
    userPace = pace;
    notifyListeners();
  }
  void setRunningPic(value) {
    runningPic = value;
    notifyListeners();
  }
  void addLocation(LatLng pos) {
    location.add(pos);
    preValue = curValue;
    curValue = pos;
  }
  void changeLen(value) {
    preLen = value;
    notifyListeners();
  }
  void setCurrentPosition(CameraPosition pos) {
    currentPosition = pos;
  }
  void setMapController(GoogleMapController con) {
    mapController = con;
  }

  void setLat(value) {
    if (minLat > value) {
      minLat = value;
    }
    else if (maxLat < value) {
      maxLat = value;
    }
  }

  void setLng(value) {
    if (minLng > value) {
      minLng = value;
    }
    else if (maxLng < value) {
      maxLng = value;
    }
  }

  void firstMinMax(LatLng value) {
    minLat = value.latitude;
    minLng= value.longitude;
    maxLat = value.latitude;
    maxLng = value.longitude;
  }
}

class UserInfo extends ChangeNotifier {
  var userId = 1;
  var nickname = '임범규';
  var height = 185;
  var weight = 70;
  String profileImg = 'https://cdn.ggilbo.com/news/photo/201812/575659_429788_3144.jpg';
// 유저 정보를 수정하는 함수 여기에 작성
// 정보 수정하고 바로 적용하려면 마지막에 notifyListers(); 코드 추가
}

class ForDate extends ChangeNotifier {
  DateTime forFocus = DateTime.now();

  void changeValue(value) {
    forFocus = value;
    notifyListeners();
  }
}


void main() async {
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => UserInfo()) ,
        ChangeNotifierProvider(create: (c) => RunningData()) ,
        ChangeNotifierProvider(create: (c) => ForDate()) ,
      ],
      child: MaterialApp(
        initialRoute: '/',
        theme: ThemeData(
          scaffoldBackgroundColor: BACKGROUND_COLOR,
          fontFamily: 'pretendard',
          textTheme: TextTheme(
            headline1: TextStyle(
              color: MAIN_COLOR,
              fontFamily: 'Pretendard',
              fontSize: 16.0,
            ),
          ),
        ),
        routes: {
          '/': (context) => HomeScreen(),
          '/Detail': (context) => ChallengeRunning(
          ),
          '/UnderRunning': (context) => UnderRunning(),
          '/UnderChallenge': (context) => UnderChallenge(),
        },
      ),
    );
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:another/constant/view/splash_screen.dart';
import 'package:another/watch/screen/watch_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:another/constant/const/color.dart';
import 'package:another/screens/home_screen.dart';
import 'package:another/screens/running/challenge_running.dart';
import 'package:another/screens/running/under_challenge.dart';
import 'package:another/screens/running/under_running.dart';
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;

class RunningSetting extends ChangeNotifier {
  int distance = 0;
  int hour = 0;
  int min = 0;
  List<int> interval = [0, 0];
  void setData(d, h, m, i) {
    distance = d;
    hour = h;
    min = m;
    interval = i;
    notifyListeners();
  }
}

class RunningData extends ChangeNotifier {
  late GoogleMapController mapController;
  CameraPosition currentPosition = CameraPosition(target: LatLng(0,0), zoom: 13);
  String runningId = '';
  LatLng preValue = LatLng(0, 0);
  LatLng curValue = LatLng(0, 0);
  String runningTime = '00:00:00';
  double runningDistance = 0;
  int userCalories = 0;
  String userPace = "0'00''";
  int preLen = 0;
  var runningPic;
  double minLat = 90;
  double minLng = 180;
  double maxLat = -90;
  double maxLng = -180;
  int stopCount = 0;
  List<Polyline> polyLine = [];
  bool stopFlag = false;

  void reset() {
    preValue = LatLng(0, 0);
    curValue = LatLng(0, 0);
    runningTime = '00:00:00';
    runningDistance = 0;
    userCalories = 0;
    userPace = "0'00''";
    preLen = 1;
    stopCount = 0;
    polyLine = [];
    stopFlag = false;
  }
  void funcStopFlag() {
    if (stopFlag == false) {
      stopFlag = true;
    }
    else {
      stopFlag = false;
    }
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
  void addLocation(LatLng pos, int v) {
    if (v == 0) {
      preValue = curValue;
      curValue = pos;
    }
    if (v == 1) {
      preValue = pos;
      curValue = pos;
    }
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
  void funcStop() {
    stopCount = polyLine.length;
  }
  void addPolyLine(int value, LatLng latLng) {
    polyLine[value].points.add(latLng);
  }
  void newPolyLine(LatLng latLng, int value) {
    List<LatLng> forPoly = [];
    forPoly.add(latLng);
    Polyline newPoly = Polyline(
      polylineId: PolylineId('poly$value'),
      points: forPoly,
      color: MAIN_COLOR,
      // jointType: JointType.round,
    );
    polyLine.add(newPoly);
  }
}


class ChallengeData extends ChangeNotifier {
  String runningId = '';
  String runningDistance = '';
  String runningTime = '';
  String userCalorie = '';
  String userPace = '';
  String hostRunningId = '';
  List<double> challengeDistanceList = [];


  void setValues(String id, String distance, String time, String calorie, String pace) {
    hostRunningId = id;
    runningDistance = distance;
    runningTime = time;
    userCalorie = calorie;
    userPace = pace;
    notifyListeners();
  }
  void setList(List<double> DistanceList){
    challengeDistanceList = DistanceList;
  }
  void reset() {
    hostRunningId = '';
    runningDistance = '';
    runningTime = '';
    userCalorie = '';
    userPace = '';

    notifyListeners();
  }
  void forRunId(v) {
    runningId = v;
  }
}


class UserInfo extends ChangeNotifier {
  int userId = 1;
  // String? accessToken;
  // String? refreshToken;

  void updateUserInfo(String userId) {
    this.userId = int.parse(userId);
    // this.accessToken = accessToken;
    // this.refreshToken = refreshToken;
    notifyListeners();
    }
  var nickname = '임범규';
  var height = 185;
  var weight = 70;
  String profileImg = 'https://cdn.ggilbo.com/news/photo/201812/575659_429788_3144.jpg';
// 유저 정보를 수정하는 함수 여기에 작성
// 정보 수정하고 바로 적용하려면 마지막에 notifyListers(); 코드 추가
}

class ForDate extends ChangeNotifier {
  DateTime forFocus = DateTime.now();
  var forFocusFormat;
  void changeValue(value) {
    forFocus = value;
    print(forFocus);
    print('-=-=-=-=-=');
    forFocusFormat = DateFormat('yyyy-MM-dd').format(forFocus);
    print(forFocusFormat);
    notifyListeners();
  }
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // print(device);

  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        print(constraints);
        if (constraints.maxHeight > 300) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (c) => UserInfo()),
              ChangeNotifierProvider(create: (c) => RunningData()),
              ChangeNotifierProvider(create: (c) => ForDate()),
              ChangeNotifierProvider(create: (c) => ChallengeData()),
              ChangeNotifierProvider(create: (c) => RunningSetting()),
            ],
            child: MaterialApp(
              initialRoute: '/',
              // home: SplashScreen(),
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
                // '/': (context) => HomeScreen(),
                '/': (context) => SplashScreen(),
                '/Detail': (context) => ChallengeRunning(
                ),
                '/UnderRunning': (context) => UnderRunning(),
                '/UnderChallenge': (context) => UnderChallenge(),
              },
            ),
          );
        } else {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (c) => RunningSetting()),
            ],
            child: MaterialApp(
              home: const WathchHomeScreen(),
              theme: ThemeData(
                  platform: TargetPlatform.android,
                  scaffoldBackgroundColor: BACKGROUND_COLOR),

            ),
          );
        }
      }

    );
  }
}

void receiveDataFromPhone() {
  const messageChannel =
  const BasicMessageChannel<String>('com.example.another', StringCodec());
  print('안돼?');
  // 데이터 수신
  messageChannel.setMessageHandler(
        (String? data) async {
      if (data != null) {
        final decodedData = json.decode(data);
        print(decodedData);
        return decodedData;
      } else {
        return 'ddd';
      }
    },
  );
  print('안돼????');
}
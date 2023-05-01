import 'package:another/constant/color.dart';
import 'package:another/screens/home_screen.dart';
import 'package:another/screens/running/running.dart';
import 'package:another/screens/running/under_challenge.dart';
import 'package:another/screens/running/under_running.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class UserInfo extends ChangeNotifier {
  var nickname = '임범규';
  var height = 185;
  var weight = 70;
  var profileImg = 'assets/img/kazuha.jpg';
  // 유저 정보를 수정하는 함수 여기에 작성
  // 정보 수정하고 바로 적용하려면 마지막에 notifyListers(); 코드 추가
}

void main() async {
  await initializeDateFormatting();
  runApp(
    ChangeNotifierProvider(
      create: (c) => UserInfo(),
      child: MaterialApp(
        initialRoute: 'home',
        theme: ThemeData(
            scaffoldBackgroundColor: BACKGROUND_COLOR,
            fontFamily: 'pretendard',
            textTheme: TextTheme(
                headline1: TextStyle(
              color: MAIN_COLOR,
              fontFamily: 'Pretendard',
              fontSize: 50.0,
            ))),
        routes: {
          'home': (context) => HomeScreen(),
          'UnderRunning': (context) => UnderRunning(),
          'UnderChallenge': (context) => UnderChallenge(),
        },
      ),
    ),
  );
}

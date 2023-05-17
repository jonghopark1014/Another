import 'package:another/constant/const/color.dart';
import 'package:another/constant/const/data.dart';
import 'package:another/constant/layout/main_layout.dart';
import 'package:another/main.dart';
import 'package:another/screens/account/login.dart';
import 'package:another/screens/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late UserInfo userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = Provider.of<UserInfo>(context, listen: false);
    // deleteToken();
    checkToken();
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);


    final dio = Dio();

    try {
      final resp = await dio.post(
        '$baseUrl/user/valid/refresh',
        data: {
          'refresh': refreshToken,
        },
      );
      int userId = resp.data['data']['userId'];
      String nickname = resp.data['data']['nickname'];
      int height = resp.data['data']['height'];
      int weight = resp.data['data']['weight'];
      print(userId);
      userInfo.updateUserInfo(userId, nickname, height, weight);


      await storage.write(
          key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => HomeScreen()),
            (route) => false,
      );
    } catch (e) {
      print(e);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginPage()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      backgroundColor: BACKGROUND_COLOR,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로고 들어가는 자리
            // Image(image: '' ,width: MediaQuery.of(context).size.width /2,),
            const SizedBox(
              height: 16.0,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

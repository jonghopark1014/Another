
import 'package:another/constant/const/color.dart';
import 'package:another/watch/screen/watch_time_screen.dart';
import 'package:flutter/material.dart';


class WathchHomeScreen extends StatefulWidget {
  const WathchHomeScreen({super.key});

  @override
  State<WathchHomeScreen> createState() => _WathchHomeScreenState();
}

class _WathchHomeScreenState extends State<WathchHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                '오늘도 힘차게',
                style: TextStyle(
                    color: MAIN_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              const Text(
                '달려볼까요?🏃🏻🏃🏻‍♂🏃🏻‍♀‍',
                style: TextStyle(
                    color: MAIN_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MAIN_COLOR,
                    ),
                    child: const Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        '러닝시작',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              const WatchTimeScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

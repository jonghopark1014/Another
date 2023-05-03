import 'package:another_front_wear_os/common/const/color.dart';
import 'package:another_front_wear_os/screen/watch_time_screen.dart';
import 'package:flutter_smart_watch/flutter_smart_watch.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmartWatch = true;
    final double width = isSmartWatch ? 360 : MediaQuery.of(context).size.width;
    final double height = isSmartWatch ? 360 : MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                '오늘도 힘차게 달려볼까요?😉😀😊☺🙂',
                style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: const Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      '러닝시작',
                      style: TextStyle(
                        fontSize: 24.0,
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
            ],
          ),
        ),
      ),
    );
  }
}

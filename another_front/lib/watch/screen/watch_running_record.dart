import 'dart:async';

import 'package:another/constant/const/color.dart';
import 'package:another/watch/screen/widget/carousel_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:another/watch/screen/widget/watch_record_result_box.dart';
import 'package:watch_connectivity/watch_connectivity.dart';
import 'package:wear/wear.dart';

class WatchRunningRecord extends StatefulWidget {
  const WatchRunningRecord({
    super.key,
  });

  @override
  State<WatchRunningRecord> createState() => _WatchRunningRecordState();
}

class _WatchRunningRecordState extends State<WatchRunningRecord> {
  final messageChannel =
  const BasicMessageChannel<String>('com.example.another', StringCodec());
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  bool isStart = false;
  int currentPageIndex = 0;
  int pageViewCount = 2;
  String _runningDistance = '1.5';
  String _runningTime = '00:00:00';
  String _userPace = '';
  String _userCalories = '1601';


  final _watch = WatchConnectivity();

  final _log = <String>[];
  @override
  void initState() {
    super.initState();
    _watch.messageStream.listen(_handleMessage);
    print(_runningDistance);
    // messageChannel.setMessageHandler((String? message) async {

    //   print('Received message from watch: $message');
    //   return '$message';
    // });

  }

  void _handleMessage(dynamic message) {
    if (message.containsKey('runningDistance')) {
      setState(() {
        _runningDistance = message['runningDistance'];
      });
    }
  }
  void sendData(){
  }
  // void receiveDataFromPhone() {
  //   // 데이터 수신
  //   messageChannel.setMessageHandler(
  //         (String? data) async {
  //       if (data != null) {
  //         final decodedData = json.decode(data);
  //         print(decodedData);
  //         return decodedData;
  //       } else {
  //         return 'ddd';
  //       }
  //     },
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30.0,
        centerTitle: true,
        elevation: 0,
        title: CustomCarouselIndicator(
          count: pageViewCount,
          currentIndex: currentPageIndex,
        ),
        backgroundColor: BACKGROUND_COLOR,
      ),
      body: PageView(

        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },

        children: [
          Column(
            children: [
              Expanded(
                child: RecordResultBox(
                  runningTime: _runningTime,
                  runningDistance: _runningDistance,
                  userPace: _userPace,
                  userCalories: _userCalories,
                ),
              ),
              SizedBox(height: 20.0,)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isStart
                    ? SizedBox(
                        height: 45.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MAIN_COLOR,
                            fixedSize: Size(120.0, 30.0),
                          ),
                          onPressed: onPressed,
                          child: const Text(
                            '러닝 시작',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                      height: 45.0,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MAIN_COLOR,
                            fixedSize: Size(
                              120.0,
                              30.0,
                            ),
                          ),
                          onPressed: onPressed,
                          child: const Text(
                            '일시 정지',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 45.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MAIN_COLOR,
                      fixedSize: Size(
                        120.0,
                        30.0,
                      ),
                    ),
                    onPressed: onPressed,
                    child: const Text(
                      '러닝 종료',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void onPressed() {
    setState(() {
      isStart = !isStart;
    });
  }

}

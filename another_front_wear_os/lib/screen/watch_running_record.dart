import 'package:another_front_wear_os/common/const/color.dart';
import 'package:another_front_wear_os/screen/watch_end_text.dart';
import 'package:another_front_wear_os/screen/widget/carousel_indicator.dart';
import 'package:another_front_wear_os/screen/widget/watch_record_result_box.dart';
import 'package:flutter/material.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

class WatchRunningRecord extends StatefulWidget {
  final bool connected;
  const WatchRunningRecord({
    required this.connected,
    super.key,
  });

  @override
  State<WatchRunningRecord> createState() => _WatchRunningRecordState();
}

class _WatchRunningRecordState extends State<WatchRunningRecord> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  bool isStart = true;
  int currentPageIndex = 0;
  int pageViewCount = 2;

  String _runningDistance = '';
  String _runningTime = '';
  String _userPace = '';
  String _userCalories = '';
  final _watch = WatchConnectivity();

  @override
  void initState() {
    super.initState();
    // if (widget.connected) {
    //   print(widget.connected);
    //   _initWear();
    // } else {
    //   print(widget.connected);
    // }
    _initWear();
  }

  void _initWear() {
    _watch.messageStream.listen(
      (message) => setState(
        () {
          if (message.containsKey('runningDistance')) {
            _runningDistance = message['runningDistance'].toString();
          }
          if (message.containsKey('runningTime')) {
            _runningTime = message['runningTime'];
          }
          if (message.containsKey('userPace')) {
            _userPace = message['userPace'];
          }
          if (message.containsKey('userCalories')) {
            _userCalories = message['userCalories'].toString();
          }
          if (message.containsKey('isStart')) {
            isStart = message['isStart'];
          }
          if (message.containsKey('stop')) {
            toStop();
          }
        },
      ),
    );
  }

  void _send(message) {
    _watch.sendMessage(message);
  }

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
        scrollDirection: Axis.vertical,
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
              const SizedBox(
                height: 20.0,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isStart
                    ? SizedBox(
                        height: 45.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MAIN_COLOR,
                            fixedSize: const Size(
                              120.0,
                              30.0,
                            ),
                          ),
                          onPressed: () {
                            onPressed();
                            _send({'isStart': isStart, 'stop': false});
                          },
                          child: const Text(
                            '일시 정지',
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
                            fixedSize: const Size(120.0, 30.0),
                          ),
                          onPressed: () {
                            onPressed();
                            _send({'isStart': isStart, 'stop': false});
                          },
                          child: const Text(
                            '러닝 시작',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 45.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MAIN_COLOR,
                      fixedSize: const Size(
                        120.0,
                        30.0,
                      ),
                    ),
                    onPressed: () {
                      _send({'stop': true});
                      toStop();
                    },
                    child: const Text(
                      '러닝 종료',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
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

  void toStop() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const WatchEndText(),
      ),
      (route) => false,
    );
  }
}

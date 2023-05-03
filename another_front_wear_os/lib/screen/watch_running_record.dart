import 'package:another_front_wear_os/common/const/color.dart';
import 'package:another_front_wear_os/screen/widget/carousel_indicator.dart';
import 'package:another_front_wear_os/screen/widget/watch_record_result_box.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';

class WatchRunningRecord extends StatefulWidget {
  WatchRunningRecord({
    super.key,
  });

  @override
  State<WatchRunningRecord> createState() => _WatchRunningRecordState();
}

class _WatchRunningRecordState extends State<WatchRunningRecord> {
  final PageController _pageController = PageController(initialPage: 0);
  bool isStart = false;
  int currentPageIndex = 0;
  int pageViewCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30.0,
        centerTitle: true,
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
        dragStartBehavior : DragStartBehavior.start,
        children: [Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RecordResultBox(),
            isStart ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
                fixedSize: Size(120.0, 30.0),
              ),
              onPressed: onPressed,
              child: const Text(
                  '러닝 시작',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ) : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
                fixedSize: Size(120.0, 30.0),
              ),
              onPressed: onPressed,
              child: const Text(
                '러닝 종료',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ) 
          ],
        ),
          Column(
            children: [
              Center(
                child: Text(
                  'ttt',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )
        ]
        
      ),
    );
  }
  void onPressed() {
    setState(() {
      isStart = !isStart;
    });
  }
}

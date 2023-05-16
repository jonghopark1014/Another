import 'dart:async';

import 'package:flutter/material.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  bool isLocked = false;
  var _timer;
  int seconds = 0;
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('락스크린 타이머');
      if (isLocked == false) {
        seconds += 1;
      }
      if (seconds > 5) {
        setState(() {
          isLocked = true;
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLocked
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF20173F),
                  ),
                  onLongPress: () {
                    setState(() {
                      seconds = 0;
                      isLocked = false;
                    });
                  },
                  onPressed: () {
                    print("이게 되네");
                  },
                  child: Container(),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 경로 수정해야함
                      Image.asset(
                        "assets/img/MainLogo1.png",
                        scale: 4,
                      ),
                      SizedBox(height: 50,),
                      Text(
                        '$seconds초 동안 클릭하지 않을 시 화면 보호기 활성화됩니다',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        '화면을 2초이상 누를 시 비활성화됩니다.',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                )
              ],
            ))
        : SizedBox(
            height: 0,
          );
  }
}

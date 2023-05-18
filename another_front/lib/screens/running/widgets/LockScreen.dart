import 'dart:async';

import 'package:another/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  bool isLocked = true;
  bool isPaused = false;
  var _timer;
  int seconds = 0;
  @override
  void initState() {
    print(isPaused);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      isPaused = Provider.of<RunningData>(context, listen: false).stopFlag;

      print('락스크린 타이머');
      if (isPaused == false) {
        if (isLocked == false) {
          seconds += 1;
        }
      } else {
        seconds = 0;
      }

      if (seconds > 8) {
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
        ? Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 경로 수정해야함
                      Image.asset(
                        "assets/img/MainLogo1.png",
                        scale: 4,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        '8초 동안 클릭하지 않을 시 화면 보호기 활성화됩니다',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        '화면을 2초이상 누를 시 비활성화됩니다.',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
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
              ],
            ))
        : SizedBox(
            height: 0,
          );
  }
}

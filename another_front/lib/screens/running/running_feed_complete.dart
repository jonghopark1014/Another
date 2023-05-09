import 'package:another/screens/feed/widgets/image_profile.dart';
import 'package:another/widgets/go_back_appbar_style.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant/color.dart';

class RunningFeedComplete extends StatefulWidget {
  const RunningFeedComplete({Key? key}) : super(key: key);

  @override
  State<RunningFeedComplete> createState() => _RunningFeedCompleteState();
}

class _RunningFeedCompleteState extends State<RunningFeedComplete> {
  bool checked = true;

  void onPressed() {
    setState(() {
      checked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy.MM.dd').format(now);
    print(now);
    return Stack(children: [
      Scaffold(
        appBar: GoBackAppBarStyle(),
        body: ListView(controller: _scrollController, children: [
          Column(
            children: [
              Container(
                height: 300.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/kazuha.jpg'),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageProfile(
                          radius: 25.0,
                          profilePic : '',
                          profileFontSize: 14.0,
                          nickname: '',
                        ),
                      ],
                    ),
                    Target(
                      targetname: '날짜',
                      runningDistance: '',
                      userCalorie: '',
                      runningTime: '',
                      userPace: '',
                    ),
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
      checked
          ? Container(
              decoration: BoxDecoration(
                color: Color(0x6B1C1A1E),
              ),
              child: Center(
                child: Container(
                  height: 130,
                  width: 300,
                  decoration: BoxDecoration(
                    color: WHITE_COLOR,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 1,
                          color: SERVETWO_COLOR,
                        ))),
                        height: 80,
                        child: Center(
                          child: Text(
                            '오운완 등록 완료!',
                            style: TextStyle(fontSize: 20, color: BLACK_COLOR),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: onPressed,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                        ),
                        child: Center(
                          child: Text(
                            '확인',
                            style: TextStyle(
                              fontSize: 16,
                              color: MAIN_COLOR,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Container(
              height: 0,
            )
    ]);
  }
}

Widget ImageProfileSetting() {
  return Center(
    child: Stack(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage('assets/img/kazuha.jpg'),
          radius: 45,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: MAIN_COLOR,
              radius: 15,
              child: Icon(
                Icons.edit,
                color: WHITE_COLOR,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

import 'package:another/constant/color.dart';
import 'package:another/constant/text_style.dart';
import 'package:another/main.dart';
import 'package:another/screens/feed/widgets/image_profile.dart';
import 'package:another/screens/feed/widgets/line_chart_custom.dart';
import 'package:another/widgets/go_back_appbar_style.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class FeedCreateComplete extends StatefulWidget {
  // final Uint8List? captureInfo;
  final List<Uint8List> feedPics;
  FeedCreateComplete({
    required this.feedPics,
    Key? key,}) : super(key: key);

  @override
  State<FeedCreateComplete> createState() => _FeedCreateCompleteState();
}

class _FeedCreateCompleteState extends State<FeedCreateComplete> {
  bool checked = true;
  final PageController _pageController = PageController(initialPage: 0);
  // 러닝 정보
  late String createDate;
  late String runningDistance;
  late String userCalorie;
  late String runningTime;
  late String userPace;
  // 유저 정보
  late String userNickname = '';
  // 사진 정보

  // 차트 정보
  late List<PacesData> chartDataList;

  void onPressed() {
    setState(() {
      checked = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    RunningData runningData = Provider.of<RunningData>(context, listen:false);
    createDate = runningData.runningTime;
    runningDistance = runningData.runningDistance.toStringAsFixed(3);
    userCalorie = runningData.userCalories.toString();
    runningTime = runningData.runningTime;
    userPace = runningData.userPace.toString();
    chartDataList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy.MM.dd').format(now);

    return Stack(children: [
      // 수정중
      Scaffold(
        appBar: GoBackAppBarStyle(),
        body: ListView(
          controller: _scrollController,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 300.0,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.feedPics.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.memory(
                        widget.feedPics[index],
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 프로필 정본
                          InkWell(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: MemoryImage(
                                    widget.feedPics[0],
                                  ),
                                  radius: 25.0,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  userNickname,
                                  style: MyTextStyle.sixteenTextStyle.copyWith(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Target(
                        targetname: createDate,
                        runningDistance: runningDistance,
                        userCalorie: userCalorie,
                        runningTime: runningTime,
                        userPace: userPace,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                      //   child: chartDataList.isNotEmpty
                      //       ? SizedBox(
                      //     height: 250.0,
                      //     child: Chart(
                      //       chartData: chartDataList,
                      //     ),
                      //   )
                      //       : Container(),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
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


class PacesData {
  final double runningDistance;
  final double userPace;

  PacesData({required this.runningDistance, required this.userPace});
}

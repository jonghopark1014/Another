import 'package:another/constant/const/color.dart';
import 'package:another/constant/const/text_style.dart';
import 'package:another/main.dart';
import 'package:another/screens/feed/api/detail_feed_api.dart';
import 'package:another/screens/feed/widgets/line_chart_custom.dart';
import 'package:another/screens/record/widgets/target_record_item.dart';
import 'package:another/widgets/go_back_appbar_style.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FeedCreateComplete extends StatefulWidget {
  // final Uint8List? captureInfo;
  final List<Uint8List> feedPics;
  FeedCreateComplete({
    required this.feedPics,
    Key? key,
  }) : super(key: key);

  @override
  State<FeedCreateComplete> createState() => _FeedCreateCompleteState();
}

class _FeedCreateCompleteState extends State<FeedCreateComplete> {
  int pageIndex = 0;
  var userProfile;
  bool checked = true;
  final PageController _pageController = PageController(initialPage: 0);
  // 러닝 정보
  late String runningId;
  late String createDate = '';
  late String runningDistance;
  late String userCalorie;
  late String runningTime;
  late String userPace;
  // 유저 정보
  late String userNickname = '';
  // 사진 정보

  // 차트 정보
  late List<PacesData> chartDataList = [];

  void onPressed() {
    setState(() {
      checked = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    RunningData runningData = Provider.of<RunningData>(context, listen: false);
    runningId = runningData.runningId;
    runningDistance = runningData.runningDistance.toStringAsFixed(3);
    userCalorie = runningData.userCalories.toString();
    runningTime = runningData.runningTime;
    userPace = runningData.userPace.toString();
    getChartData();
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
        appBar: GoBackAppBarStyle(
          toHome: true,
        ),
        body: ListView(
          controller: _scrollController,
          children: [
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    SizedBox(
                      height: 300.0,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          setState(() {
                            pageIndex = value;
                          });
                        },
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
                    Positioned(
                      bottom: 10,
                      child: widget.feedPics.length > 1
                          ? CarouselIndicator(
                        space: 15,
                        activeColor: MAIN_COLOR,
                        width: 8,
                        height: 8,
                        animationDuration: 0,
                        count: widget.feedPics.length,
                        index: pageIndex,
                      )
                          : Container(),
                    ),
                  ],
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
                                userProfile == null
                                    ? CircleAvatar(
                                        radius: 25.0,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          userProfile,
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: chartDataList.isNotEmpty
                      ? SizedBox(
                          height: 250.0,
                          child: Chart(
                            chartData: chartDataList,
                          ),
                        )
                      : Container(),
                ),
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

  void getChartData() async {
    List<PacesData> chartData;
    final response = await DetailFeedApi.getFeed(runningId);
    if (response != null) {
      final content = response['data'];
      print(content);
      var cTime = content['createDate'];
      print(cTime);
      List<dynamic> graph = content['graph'];
      chartData = graph.map(
        (data) {
          double d = 0.0;
          double p = 0.0;
          if (data['runningDistance'] != null && data['userPace'] != null) {
            d = data['runningDistance'] ?? 0.0;
            p = double.parse(
                data['userPace'].replaceAll("''", "").replaceAll("'", "."));
          }
          print('$runningDistance $userPace');
          return PacesData(runningDistance: d, userPace: p);
        },
      ).toList();

      setState(() {
        userNickname = content['nickname'];
        userProfile = content['profilePic'];
        chartDataList = chartData;
        createDate = cTime;
      });
    }
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

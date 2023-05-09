import 'package:flutter/material.dart';
import 'package:another/screens/feed/widgets/line_chart_custom.dart';

import 'package:another/screens/feed/widgets/image_profile.dart';
import 'package:another/screens/feed/widgets/run_icon.dart';
import 'package:another/screens/feed/api/detail_feed_api.dart';

import 'package:another/widgets/target.dart';
import '../../widgets/go_back_appbar_style.dart';

class DetailFeed extends StatefulWidget {
  final String runningId;
  DetailFeed({
    required this.runningId,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailFeed> createState() => _DetailFeedState();
}

class _DetailFeedState extends State<DetailFeed> {
  final ScrollController _scrollController = ScrollController();
  List<String> thumbnailUrls = [];
  List<PacesData> chartDataList = [];
  String runningTime = '0';
  String runningDistance = '0';
  String walkCount = '0';
  String userCalorie = '0';
  String createDate = '0';
  String userPace = '0';
  String profilePic = '';
  String userNickname = '';
  String runCount = '';
  String runId ='';

  @override
  void initState() {
    super.initState();
    _detailFeed();
  }

  // 피드 가져오기
  Future<void> _detailFeed() async {
    try {
      final response = await DetailFeedApi.getFeed(widget.runningId);
      print(widget.runningId);
      print(response);
      List<String> feedPicUrls = [];
      List<dynamic> graphs = [];
      List<PacesData> chartData = [];
      String runningTimes = '';
      String runningDistances = '';
      String walkCounts = '';
      String userCalories = '';
      String createDates = '';
      String userPaces = '';
      String profile = '';
      String nickname = '';
      String withRunCount = '';
      String runningId = '';

      if (response != null) {
        final contents = response['data'];
        runningTimes = contents['runningTime'].toString();
        runningDistances = contents['runningDistance'].toString();
        walkCounts = contents['walkCount'].toString();
        userCalories = contents['userCalories'].toString();
        createDates = contents['createDate'].toString();
        userPaces = contents['userPace'].toString();
        profile = contents['profilePic'].toString();
        nickname = contents['nickname'].toString();
        withRunCount = contents['withRunCount'].toString();
        List<dynamic> feedPics = contents['feedPics'];
        runningId = contents['runningId'].toString();

        for (var feedPic in feedPics) {
          feedPicUrls.add(feedPic['feedPic']);
        }
        feedPicUrls.add(contents['runningPic'].toString());
        graphs = contents['graph'];
        chartData = graphs.map(
          (data) {
            double runningDistance = 0.0;
            double userPace = 0.0;
            if (data['runningDistance'] != null && data['userPace'] != null) {
              runningDistance = data['runningDistance'] ?? 0.0;
              userPace = double.parse(data['userPace'].replaceAll("''", "").replaceAll("'", ".")) ?? 0.0;
            }
            return PacesData(runningDistance: runningDistance, userPace: userPace);
          },
        ).toList();
      }

      setState(
        () {
          thumbnailUrls = feedPicUrls;
          runningTime = runningTimes;
          runningDistance = runningDistances;
          userCalorie = userCalories;
          userPace = userPaces;
          walkCount = walkCounts;
          createDate = createDates;
          chartDataList = chartData;
          profilePic = profile;
          userNickname = nickname;
          runCount = withRunCount;
          runId = runningId;
        },
      );
    } catch (e) {
      print(e);
    }
  }

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  itemCount: thumbnailUrls.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      thumbnailUrls[index],
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
                        ImageProfile(
                          radius: 25.0,
                          profileFontSize: 14.0,
                          profilePic: profilePic,
                          nickname: userNickname,
                        ),
                        RunIcon(
                          runningTime: runningTime,
                          runningDistance: runningDistance,
                          userCalorie: userCalorie,
                          userPace: userPace,
                          runCount: runCount,
                            runningId: runId
                        ),
                      ],
                    ),
                    Target(
                      targetname: createDate,
                      runningDistance: runningDistance,
                      userCalorie: userCalorie,
                      runningTime: runningTime,
                      userPace: userPace,
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
              )
            ],
          ),
        ],
      ),
    );
  }
}

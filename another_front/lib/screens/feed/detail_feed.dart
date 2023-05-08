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
  String kcal = '0';
  String createDate = '0';
  String speed = '0';
  String profilePic = '';
  String userNickname = '';

  @override
  void initState() {
    super.initState();
    _detailFeed();
  }

  Future<void> _detailFeed() async {
    try {
      final response = await DetailFeedApi.getFeed(widget.runningId);
      List<String> feedPicUrls = [];
      List<dynamic> graphs = [];
      List<PacesData> chartData = [];
      String runningTimes = '';
      String runningDistances = '';
      String walkCounts = '';
      String kcals = '';
      String createDates = '';
      String speeds = '';
      String profile = '';
      String nickname = '';
      print(response);
      if (response != null) {
        final contents = response['data'];
        runningTimes = contents['runningTime'].toString();
        runningDistances = contents['runningDistance'].toString();
        walkCounts = contents['walkCount'].toString();
        kcals = contents['kcal'].toString();
        createDates = contents['createDate'].toString();
        speeds = contents['speed'].toString();
        profile = contents['profilePic'].toString();
        nickname = contents['nickname'].toString();

        List<dynamic> feedPics = contents['feedPics'];
        for (var feedPic in feedPics) {
          feedPicUrls.add(feedPic['feedPic']);
        }
        graphs = contents['graph'];
        chartData = graphs.map(
          (data) {
            double distance = 0.0;
            double speed = 0.0;
            print(data['distance']);
            if (data['distance'] != null && data['speed'] != null) {
              distance = double.parse(data['distance'] ?? '0.0');
              speed = double.parse(data['speed'] ?? '0.0');
            }
            return PacesData(distance: distance, speed: speed);
          },
        ).toList();
      }

      setState(
        () {
          thumbnailUrls = feedPicUrls;
          runningTime = runningTimes;
          runningDistance = runningDistances;
          kcal = kcals;
          speed = speeds;
          walkCount = walkCounts;
          createDate = createDates;
          chartDataList = chartData;
          profilePic = profile;
          userNickname = nickname;
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
                          kcal: kcal,
                          speed: speed,
                        ),
                      ],
                    ),
                    Target(
                      targetname: createDate,
                      runningDistance: runningDistance,
                      kcal: kcal,
                      runningTime: runningTime,
                      speed: speed,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: SizedBox(
                        height: 250.0,
                        child: Chart(
                          chartData: chartDataList,
                        ),
                      ),
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

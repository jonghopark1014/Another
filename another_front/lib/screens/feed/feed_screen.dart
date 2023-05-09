import 'package:another/constant/main_layout.dart';
import 'package:another/main.dart';
import 'package:another/screens/feed/all_feed_screen.dart';
import 'package:another/screens/feed/api/feed_api.dart';
import 'package:another/screens/feed/api/my_feed_api.dart';
import 'package:another/screens/feed/my_feed_screen.dart';
import 'package:another/screens/feed/widgets/feed_select.dart';
import 'package:another/screens/feed/widgets/my_feed_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool isFeed = true;
  late List<String> thumbnailUrls = [];
  late List<String> runningIds = [];
  late List<String> runningTimes = [];
  late List<String> runningDistances = [];
  late List<String> walkCounts = [];
  late List<String> userCalories = [];
  late var userInfo;
  late int userId;
  late String profile = '';

  @override
  void initState() {
    super.initState();
    userInfo = Provider.of<UserInfo>(
      context,
      listen: false,
    );
    userId = userInfo.userId;
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    try {
      final response = await FeedApi.getFeed();
      print(response);

      final contents = response['data']['content'];
      List<String> feedPicUrls = [];
      List<String> runningIdsList = [];
      List<String> runningTimeList = [];
      List<String> runningDistanceList = [];
      List<String> kcalList = [];

      for (var content in contents) {
        List<Map<String, dynamic>> feedPics =
            List<Map<String, dynamic>>.from(content['feedPics']);
        if (feedPics.isNotEmpty) {
          feedPicUrls.add(feedPics[0]['feedPic']);
          runningIdsList.add(content['runningId'].toString());
          runningTimeList.add(content['runningTime'].toString());
          runningDistanceList.add(content['runningDistance'].toString());
          kcalList.add(content['userCalories'].toString());
        } else {
          feedPicUrls.add(content['runningPic'].toString());
          runningIdsList.add(content['runningId'].toString());
          runningTimeList.add(content['runningTime'].toString());
          runningDistanceList.add(content['runningDistance'].toString());
          kcalList.add(content['userCalories'].toString());
        }
      }
      print(runningIdsList);
      setState(
        () {
          thumbnailUrls = feedPicUrls;
          runningIds = runningIdsList;
          runningTimes = runningTimeList;
          runningDistances = runningDistanceList;
          userCalories = kcalList;
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _myFeed() async {
    try {
      final response = await MyFeedApi.getFeed('$userId');
      final contents = response['data']['myFeedListDtos']['content'];
      List<String> feedPicUrls = [];
      List<String> runningIdsList = [];
      List<String> runningTimeList = [];
      List<String> runningDistanceList = [];
      List<String> walkCountList = [];
      List<String> kcalList = [];
      String profilePic = '';
      print(response);

      if (contents != []) {
        for (var content in contents) {
          List<Map<String, dynamic>> feedPics =
              List<Map<String, dynamic>>.from(content['feedPic']);
          if (feedPics.isNotEmpty) {
            feedPicUrls.add(feedPics[0]['feedPic']);
            runningIdsList.add(content['runningId'].toString());
            runningTimeList.add(content['runningTime'].toString());
            runningDistanceList.add(content['runningDistance'].toString());
            walkCountList.add(content['walkCount'].toString());
            kcalList.add(content['userCalories'].toString());
          } else {
            feedPicUrls.add(content['runningPic'].toString());
            runningIdsList.add(content['runningId'].toString());
            runningTimeList.add(content['runningTime'].toString());
            runningDistanceList.add(content['runningDistance'].toString());
            kcalList.add(content['userCalories'].toString());
          }
        }
      } else {
        // runningIdsList.add('0');
        // runningTimeList.add('0');
        // runningDistanceList.add('0');
        // walkCountList.add('0');
        // kcalList.add('0');
      }

      setState(
        () {
          profilePic = response['data']['profilePic'];
          thumbnailUrls = feedPicUrls;
          runningIds = runningIdsList;
          runningTimes = runningTimeList;
          runningDistances = runningDistanceList;
          walkCounts = walkCountList;
          userCalories = kcalList;
          profile = profilePic;
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('로고'),
              expandedHeight: 25.0,
              backgroundColor: BACKGROUND_COLOR,
            ),
            SliverToBoxAdapter(
              child: isFeed
                  ? Container()
                  : MyRecordResult(
                      walkCounts: walkCounts,
                      userCalories:
                          userCalories.isNotEmpty ? userCalories : ['0'],
                      runningTimes:
                          runningTimes.isNotEmpty ? runningTimes : ['0'],
                      runningDistances: runningDistances.isNotEmpty
                          ? runningDistances
                          : ['0'],
                      profile: profile,
                    ),
            ),
          ];
        },
        body: Column(
          children: [
            FeedSelect(
              onChanged: (value) {
                setState(
                  () {
                    isFeed = value;
                    if (isFeed) {
                      _loadFeed();
                    } else {
                      _myFeed();
                    }
                  },
                );
              },
            ),
            Expanded(
              child: isFeed
                  ? AllFeedScreen(
                      thumbnailUrls: thumbnailUrls,
                      runningIds: runningIds,
                      runningTimes: runningTimes,
                      runningDistances: runningDistances,
                      userCalories: userCalories,
                    )
                  : MyFeedScreen(
                      thumbnailUrls: thumbnailUrls,
                      runningIds: runningIds,
                      runningTimes: runningTimes,
                      runningDistances: runningDistances,
                      // walkCounts: walkCounts,
                      userCalories: userCalories,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

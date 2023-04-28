import 'package:another/screens/feed/all_feed_screen.dart';
import 'package:another/screens/feed/my_feed_screen.dart';
import 'package:another/screens/feed/widgets/feed_select.dart';
import 'package:another/screens/feed/widgets/my_feed_result.dart';
import 'package:flutter/material.dart';

import '../../constant/color.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool isFeed = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: Text('로고'),
                    expandedHeight: 25.0,
                    backgroundColor: BACKGROUND_COLOR,
                    pinned: false, // true 처리 시 스크롤을 내려도 appbar가 작게 보임
                    floating: false, // true 처리 시 스크롤을 내릴때 appbar가 보임
                    snap:
                        false, // true 처리 시 스크롤 내리면 appbar가 풀로 보임 (floating true조건)

                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: isFeed ? Container() : MyRecordResult()
                      ),
                ];
              },
              body: Column(
                children: [
                  FeedSelect(
                    onChanged: (value) {
                      setState(() {
                        isFeed = value;
                      });
                    },
                  ),
                  Expanded(child: isFeed ? AllFeedScreen() : MyFeedScreen()),
                ],
              )),
        ),
      ),
    );
  }
}

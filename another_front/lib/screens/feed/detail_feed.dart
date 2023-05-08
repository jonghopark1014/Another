import 'package:flutter/material.dart';

import 'package:another/screens/feed/widgets/image_profile.dart';
import 'package:another/screens/feed/widgets/run_icon.dart';
import 'package:another/widgets/target.dart';

import '../../widgets/go_back_appbar_style.dart';
import 'package:another/screens/feed/api/detail_feed_api.dart';

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



  @override
  void initState() {
    super.initState();
    _detailFeed();
  }

  Future<void> _detailFeed() async {
    try {
      final response = await DetailFeedApi.getFeed(widget.runningId);
      if (response != null) {
        final contents = response['data']['content'];
        if (contents != null && contents.isNotEmpty) {
          List<Map<String, dynamic>> feedPicUrls = [];
          for (var content in contents) {
            List<Map<String, dynamic>> feedPics =
            List<Map<String, dynamic>>.from(content['feedPic']);
            for (var feedPic in feedPics) {
              feedPicUrls.add(feedPic);
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBarStyle(),
      body: ListView(
        controller: _scrollController,
        children: [
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
                          profileFontSize: 14.0,
                        ),
                        RunIcon(),
                      ],
                    ),
                    Target(targetname: '날짜'),
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

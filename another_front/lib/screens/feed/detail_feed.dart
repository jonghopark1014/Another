import 'package:flutter/material.dart';

import 'package:another/screens/feed/widgets/image_profile.dart';
import 'package:another/screens/feed/widgets/run_icon.dart';
import 'package:another/widgets/target.dart';

import '../../widgets/go_back_appbar_style.dart';

class DetailFeed extends StatefulWidget {
  const DetailFeed({Key? key}) : super(key: key);

  @override
  State<DetailFeed> createState() => _DetailFeedState();
}

class _DetailFeedState extends State<DetailFeed> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ]),
    );
  }
}

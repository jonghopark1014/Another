import 'package:another/constant/color.dart';
import 'package:another/constant/text_style.dart';
import 'package:another/screens/feed/api/challenge_list_api.dart';
import 'package:another/widgets/go_back_appbar_style.dart';
import 'package:flutter/material.dart';

import 'widgets/image_profile.dart';

class ChallengeList extends StatefulWidget {
  final String runningId;

  ChallengeList({
    required this.runningId,
    Key? key,
  }) : super(key: key);

  @override
  State<ChallengeList> createState() => _ChallengeListState();
}

class _ChallengeListState extends State<ChallengeList> {
  final ScrollController _scrollController = ScrollController();
  late List<String> profilePicList = [];
  late List<String> nicknameList = [];

  @override
  void initState() {
    super.initState();
    _challengeListApi();
  }

  Future<void> _challengeListApi() async {
    try {
      final response = await ChallengeListApi.getFeed('1');
      final contents = response['data'];
      List<String> profilePics = [];
      List<String> nicknames = [];
      for (var content in contents) {

        nicknames.add(content['nickname']);
        profilePics.add(content['profilePic']);
      }

      setState(
        () {
          profilePicList = profilePics;
          nicknameList = nicknames;
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBarStyle(
        runningId: widget.runningId,
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '함께달린 사람',
                  style: MyTextStyle.twentyFiveTextStyle,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  '${profilePicList.length}',
                  style: MyTextStyle.twentyFiveTextStyle,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: profilePicList.length,
                itemBuilder: (BuildContext context,int index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ImageProfile(
                      radius: 35.0,
                      profileFontSize: 20.0,
                      nickname: nicknameList[index],
                      profilePic: profilePicList[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}

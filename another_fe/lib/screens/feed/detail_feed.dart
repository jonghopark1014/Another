import 'package:another/constant/color.dart';
import 'package:another/screens/feed/widgets/challenge_list.dart';
import 'package:another/screens/feed/widgets/image_profile.dart';
import 'package:another/widgets/record_result.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/material.dart';

class DetailFeed extends StatelessWidget {
  const DetailFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR,
      ),
      body: Column(
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
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
    );
  }
}

class RunIcon extends StatelessWidget {
  const RunIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      InkWell(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChallengeList(),
            ),
          );
        },
        child: SizedBox(
          width: 45.0,
          child: Stack(
            children: [
              Icon(
                Icons.directions_run,
                size: 30.0,
                color: WHITE_COLOR,
              ),
              Positioned(
                left: 14,
                child: Icon(
                  Icons.directions_run,
                  size: 30.0,
                  color: WHITE_COLOR,
                ),
              )
            ],
          ),
        ),
      ),
      InkWell(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChallengeList(),
            ),
          );
        },
        child: Text(
          '25',
          style: TextStyle(color: WHITE_COLOR, fontSize: 16.0),
        ),
      ),
      SizedBox(
        width: 10.0,
      ),
      ElevatedButton(
        onPressed: () {

        },
        style: ElevatedButton.styleFrom(
          primary: MAIN_COLOR,
        ),
        child: Text('기록에 도전하기'),
      ),
    ]);
  }
}

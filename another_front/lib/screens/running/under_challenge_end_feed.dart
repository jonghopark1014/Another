import 'package:another/main.dart';
import 'package:another/screens/running/running_feed_complete.dart';
import 'package:another/widgets/go_back_appbar_style.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';

class UnderChallengeScreenEndFeed extends StatefulWidget {
  final Uint8List? captureInfo;
  UnderChallengeScreenEndFeed({required this.captureInfo, Key? key})
      : super(key: key);

  @override
  State<UnderChallengeScreenEndFeed> createState() => _UnderChallengeScreenEndFeedState();
}

class _UnderChallengeScreenEndFeedState extends State<UnderChallengeScreenEndFeed> {
  // 표시할 사진들 위젯
  final List<Widget> loadedImg = [];
  // 받아올 사진들 정보
  late List<XFile?> images = [];
  // 표시할 데이터
  late String runningDistance;
  late String userCalorie;
  late String runningTime;
  late String userPace;

  @override
  void initState() {
    // TODO: implement initState
    var runningData = Provider.of<RunningData>(context, listen: false);
    runningDistance = runningData.runningDistance.toString();
    userCalorie = runningData.userCalories.toString();
    runningTime = runningData.runningTime;
    userPace = runningData.userPace;
    loadedImg.add(SizedBox(
      height: 350.0,
      child: Image.memory(
        widget.captureInfo!,
        fit: BoxFit.cover,
      ),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: GoBackAppBarStyle(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: MAIN_COLOR,
                  side: BorderSide(
                    color: MAIN_COLOR,
                    width: 2.5,
                  ),
                ),
                onPressed: onTapPressed
                //     () {
                //   Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (_) => CustomImage(),
                //     ),
                //   );
                // }
                ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_camera_outlined),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                      ),
                      child: Text(
                        '사진 추가하기',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 350.0,
                  child: Image.memory(
                    widget.captureInfo!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Target(
                targetname: '내 기록',
                runningDistance: runningDistance,
                userCalorie: userCalorie,
                runningTime: runningTime,
                userPace: userPace,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MAIN_COLOR,
                    elevation: 20.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => RunningFeedComplete()),
                        (route) => route.settings.name == '/');
                  },
                  child: Text(
                    '오운완 등록하기',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onTapPressed() async {
    print('사진 아이콘');
    final image = await ImagePicker().pickMultiImage(
      imageQuality: 100,
    );
    print('선택완료');
    print(image);
    setState(() {
      images = image;
    });
  }
  
  // 이미지 불러올지, 사진 찍을지 고르기
  // Future<dynamic> toImageSelector() {
  //   return showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //
  //         );
  //       }
  //   );
  // }
}

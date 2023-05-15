import 'dart:io';

import 'package:another/constant/const/color.dart';
import 'package:another/main.dart';
import 'package:another/screens/running/api/feed_create_api.dart';
import 'package:another/screens/running/feed_create_complete.dart';
import 'package:another/widgets/go_back_appbar_style.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UnderChallengeScreenEndFeed extends StatefulWidget {
  final Uint8List? captureInfo;
  UnderChallengeScreenEndFeed({required this.captureInfo, Key? key})
      : super(key: key);

  @override
  State<UnderChallengeScreenEndFeed> createState() => _UnderChallengeScreenEndFeedState();
}

class _UnderChallengeScreenEndFeedState extends State<UnderChallengeScreenEndFeed> {
  // api 요청용
  late int userId = Provider.of<UserInfo>(context, listen: false).userId as int;
  late String runningId;
  List<Uint8List> feedPics = [];
  // 고른 사진들
  List<Uint8List> pickedImgs = [];
  // 뛴지도 사진
  late final Uint8List runPic;
  // 받아올 사진들 정보
  late List<Uint8List> images = [];
  // 표시할 데이터
  late String runningDistance;
  late String userCalorie;
  late String runningTime;
  late String userPace;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // 홈스크린 라우터에 추가
    // TODO: implement initState
    var runningData = Provider.of<RunningData>(context, listen: false);
    runningId = runningData.runningId;
    runningDistance = runningData.runningDistance.toStringAsFixed(3);
    userCalorie = runningData.userCalories.toString();
    runningTime = runningData.runningTime;
    userPace = runningData.userPace;

    runPic = widget.captureInfo!;
    feedPics.add(runPic);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('리빌드');
    return Scaffold(
      appBar: GoBackAppBarStyle(toHome: true,),
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
                onPressed: onTapPressed ,
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
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 2,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PageView.builder(
                      controller: _pageController,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 350.0,
                          child: Image.memory(
                            feedPics[index],
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                      itemCount: feedPics.length,
                    ),
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
                  onPressed: () async {
                    // 등록 요청 하고 페이지 이동하도록?
                    bool isComplete = await feedCreateApi(userId, runningId, feedPics);
                    // 현재 위젯이 그대로 마운트 되어있을때
                    if (context.mounted) {
                      if (isComplete) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => FeedCreateComplete(feedPics: feedPics,)),
                                (route) => false);
                      } else {
                        // 미완료 모달창
                      }

                    }

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
  // 저장된 이미지 가져오기
  void onTapPressed() async {
    final imageXFiles = await ImagePicker().pickMultiImage(
      imageQuality: 100,
    );
    // xfile(path) 를 uint8list(이미지 데이터)로 변환
    for (var i = 0; i < imageXFiles.length; i++) {
      File file = File(imageXFiles[i].path);
      Uint8List imgByteList = await file.readAsBytes();
      // 받아온 이미지 위젯리스트에 추가
      pickedImgs.add(imgByteList);
    }
    setState(() {
      feedPics = [...pickedImgs];
      feedPics.add(runPic);
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

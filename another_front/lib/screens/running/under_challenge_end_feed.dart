import 'dart:io';

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
  List<Widget> imageWidgetList = [];
  // 고른 사진들 위젯
  List<Widget> pickedImgWidget = [];
  // 뛴지도 위젯
  late final Widget runPicWidget;
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
    // TODO: implement initState
    var runningData = Provider.of<RunningData>(context, listen: false);
    runningDistance = runningData.runningDistance.toStringAsFixed(3);
    userCalorie = runningData.userCalories.toString();
    runningTime = runningData.runningTime;
    userPace = runningData.userPace;
    runPicWidget = SizedBox(
      height: 350.0,
      child: Image.memory(
        widget.captureInfo!,
        fit: BoxFit.contain,
      ),
    );
    imageWidgetList.add(runPicWidget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('리빌드');
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
                        return imageWidgetList[index];
                      },
                      itemCount: imageWidgetList.length,
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
      pickedImgWidget.add(
          SizedBox(
            height: 350.0,
            child: Image.memory(
              imgByteList,
              fit: BoxFit.contain,
            ),
          )
      );
    }
    setState(() {
      imageWidgetList = [...pickedImgWidget];
      imageWidgetList.add(runPicWidget);
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

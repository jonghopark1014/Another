import 'dart:io';

import 'package:another/constant/const/color.dart';
import 'package:another/constant/const/text_style.dart';
import 'package:another/main.dart';
import 'package:another/screens/running/api/feed_create_api.dart';
import 'package:another/screens/running/feed_create_complete.dart';
import 'package:another/widgets/go_back_appbar_style.dart';
import 'package:another/widgets/target.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UnderChallengeScreenEndFeed extends StatefulWidget {
  final Uint8List? captureInfo;
  UnderChallengeScreenEndFeed({required this.captureInfo, Key? key})
      : super(key: key);

  @override
  State<UnderChallengeScreenEndFeed> createState() =>
      _UnderChallengeScreenEndFeedState();
}

class _UnderChallengeScreenEndFeedState
    extends State<UnderChallengeScreenEndFeed> {
  bool isEnrollStarted = false;
  int pageIndex = 0;
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
      appBar: GoBackAppBarStyle(
        toHome: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                onPressed: () => _showPicker(context),
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
                  maxHeight: MediaQuery.of(context).size.height / 11 * 5,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          PageView.builder(
                            onPageChanged: (value) {
                              setState(() {
                                pageIndex = value;
                              });
                            },
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
                          Positioned(
                            bottom: 10,
                            child: feedPics.length > 1
                                ? CarouselIndicator(
                                    space: 15,
                                    activeColor: MAIN_COLOR,
                                    width: 8,
                                    height: 8,
                                    animationDuration: 0,
                                    count: feedPics.length,
                                    index: pageIndex,
                                  )
                                : Container(),
                          )
                        ]),
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
                  onPressed: () async {
                    // 등록 요청 하고 페이지 이동하도록?
                    if (isEnrollStarted == false) {
                      setState(() {
                        isEnrollStarted = true;
                      });
                      bool isComplete =
                          await feedCreateApi(userId, runningId, feedPics);
                      // 현재 위젯이 그대로 마운트 되어있을때
                      if (context.mounted) {
                        if (isComplete) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => FeedCreateComplete(
                                        feedPics: feedPics,
                                      )),
                              (route) => false);
                        } else {
                          isEnrollStarted = false;
                          // 미완료 모달창
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: MAIN_COLOR,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    elevation: 10.0,
                  ),
                  child: Text(
                    '오운완 등록하기',
                    style: MyTextStyle.twentyTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 카메라로 사진 찍기
  void _getCameraImage() async {
    final imageXFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageXFile != null) {
      File file = File(imageXFile.path);
      Uint8List imgByteList = await file.readAsBytes();
      // 받아온 이미지 위젯리스트에 추가
      pickedImgs.add(imgByteList);
      setState(() {
        feedPics = [...pickedImgs];
        feedPics.add(runPic);
      });
    }
  }

  // 갤러리에서 사진 선택
  void _getPhotoLibraryImage() async {
    final imageXFiles = await ImagePicker().pickMultiImage(
      imageQuality: 100,
    );
    // xfile(path) 를 uint8list(이미지 데이터)로 변환
    if (imageXFiles != null) {
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
  }

  // 바텀 시트에서 선택지를 보여줍니다.
  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            color: SERVEONE_COLOR,
          ),
          height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text(
                  "사진 촬영",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _getCameraImage();
                },
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text(
                  "갤러리에서 선택",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _getPhotoLibraryImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

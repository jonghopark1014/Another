import 'package:another/main.dart';
import 'package:another/screens/record/widgets/record_chart.dart';
import 'package:another/screens/running/api/recommend_challenge_api.dart';
import 'package:another/screens/running/api/run_compare_month_api.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/const/color.dart';

class RunningCarousel extends StatefulWidget {
  RunningCarousel({
    super.key,
  });
  @override
  State<RunningCarousel> createState() => _RunningCarouselState();
}

class _RunningCarouselState extends State<RunningCarousel> {
  final PageController _pageController = PageController(initialPage: 0);
  late int userId;
  int pageIndex = 0;
  // 페이지 두개
  late final List<Widget> _carouselPages;

  @override
  void initState() {
    _carouselPages = [
      Container(),
      Container(),
    ];
    userId = Provider.of<UserInfo>(context, listen: false).userId as int;
    print('$userId==================================');
    // TODO: implement initState
    getRecommendChallenge();
    getCompareData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.fromLTRB(15, 70, 15, 0),
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CONTOUR_COLOR,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ]
      ),
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
            itemCount: _carouselPages.length,
            itemBuilder: (BuildContext context, int index) {
              return _carouselPages[index];
            },
          ),
          Positioned(
            bottom: 10,
            child: CarouselIndicator(
              space: 15,
              activeColor: MAIN_COLOR,
              width: 8,
              height: 8,
              animationDuration: 0,
              count: _carouselPages.length,
              index: pageIndex,
            ),
          )
        ],
      ),
    );
  }

  void getCompareData() async {
    print('runcomparemonth');
    var response = await runCompareMonthApi(userId);
    print(response);
    if (response['status'] == 'success') {
      setState(
        () {
          var runCompareData = response['data'];
          // if (runCompareData!['lastMonthDistance'] < 1) {
          //   runCompareData!['lastMonthDistance'] * 1000;
          // }
          // runCompareData!['thisMonthDistance']
          _carouselPages[1] = Container(
            alignment: Alignment(0, 0.5),
            color: CONTOUR_COLOR,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${runCompareData!['lastMonthDistance'].toStringAsFixed(3).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}km',
                        style: TextStyle(
                          color: WHITE_COLOR,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        '지난달',
                        style: TextStyle(
                          color: WHITE_COLOR,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${runCompareData!['thisMonthDistance'].toStringAsFixed(3).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}km',
                        style: TextStyle(
                          color: WHITE_COLOR,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        '이번달',
                        style: TextStyle(
                          color: WHITE_COLOR,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void getRecommendChallenge() async {
    print('????');
    var response = await recommendChallengeApi(userId);
    print(response);
    if (response['status'] == 'success') {
      setState(
        () {
          _carouselPages[0] = Container(
            // alignment: Alignment(0, 0.5),
            color: CONTOUR_COLOR,

            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
              child: response['data'] == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/img/gold_firstrun.png',
                          height: 85,
                          width: 85,
                        ),
                        Text(
                          "첫 러닝을 시작해볼까요😀",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                          response['data']['challengeGold'],
                          height: 85,
                          width: 85,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${response['data']['challengeName']}',
                              style: TextStyle(
                                color: SERVEONE_COLOR,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '뱃지를 획득해보세요!',
                              style: TextStyle(
                                  fontSize: 14, color: SERVETWO_COLOR),
                            ),
                          ],
                        )
                      ],
                    ),
            ),
          );
        },
      );
      print("////////////");
    }
  }
}

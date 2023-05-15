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
      Center(
        child: CircularProgressIndicator(),
      ),
      Center(
        child: CircularProgressIndicator(),
      ),
    ];
    userId = Provider.of<UserInfo>(context, listen: false).userId as int;
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
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CONTOUR_COLOR,
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
      setState(() {
        var runCompareData = response['data'];
        _carouselPages[1] = Container(
          alignment: Alignment(0, 0.5),
          color: CONTOUR_COLOR,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 그래프 높이 85
                SizedBox(
                  height: 85,
                  child: RecordChart(
                      '',
                      runCompareData!['lastMonthDistance']!,
                      runCompareData!['thisMonthDistance']!,
                      runCompareData!['lastMonthDistance'].toString(),
                      runCompareData!['thisMonthDistance'].toString(),
                      ),
                ),
                Text(
                  "나의 기록 그래프",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        );
      });
    }
  }

  void getRecommendChallenge() async {
    print('????');
    var response = await recommendChallengeApi(userId);
    print(response);
    if (response['status'] == 'success') {
      setState(() {
        _carouselPages[0] = Container(
          // alignment: Alignment(0, 0.5),
          color: CONTOUR_COLOR,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: response['data'] == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/img/10min_gold.png',
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
                      Text(
                        response['data']['challengeName'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
          ),
        );
      });
      print("////////////");
    }
  }
}

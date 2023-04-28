
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/color.dart';

class RunningCarousel extends StatefulWidget {
  RunningCarousel({
    super.key,
  });

  final List<Widget> _carouselPages=[
    Container(
      // alignment: Alignment(0, 0.5),
      color: CONTOUR_COLOR,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/img/10min_gold.png', height: 85, width: 85,),
            Text(
              "첫 러닝을 시작해볼까요😀",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    ),
    Container(
      alignment: Alignment(0, 0.5),
      color: CONTOUR_COLOR,
      child: Text(
        "나의 기록 그래프",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ];
  @override
  State<RunningCarousel> createState() => _RunningCarouselState();
}

class _RunningCarouselState extends State<RunningCarousel> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.fromLTRB(15, 70, 15, 0),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BACKGROUND_COLOR,
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView(
            children: widget._carouselPages,
            onPageChanged: (index){
              setState(() {
                pageIndex=index;
              });
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
              count: widget._carouselPages.length,
              index: pageIndex,
            ),
          )
        ],
      ),
    );
  }
}

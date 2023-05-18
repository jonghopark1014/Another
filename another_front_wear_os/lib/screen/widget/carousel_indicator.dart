import 'package:another_front_wear_os/common/const/color.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/material.dart';


class CustomCarouselIndicator extends StatelessWidget implements PreferredSizeWidget {
  final int count;
  final int currentIndex;

  const CustomCarouselIndicator({
    Key? key,
    required this.count,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselIndicator(
      activeColor: MAIN_COLOR,
      count: count,
      index: currentIndex,
      width: 8.0,
      height: 8.0,
      space: 15.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
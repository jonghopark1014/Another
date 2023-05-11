import 'package:flutter/cupertino.dart';

class ImageListCarousel extends StatefulWidget {
  final List<Widget> imageWidgetList;
  const ImageListCarousel({required this.imageWidgetList, Key? key})
      : super(key: key);

  @override
  State<ImageListCarousel> createState() => _ImageListCarouselState();
}

class _ImageListCarouselState extends State<ImageListCarousel> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: PageView.builder(
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return widget.imageWidgetList[index];
          },
          itemCount: widget.imageWidgetList.length,
        ),);
  }
}

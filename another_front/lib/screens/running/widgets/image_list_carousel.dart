import 'package:flutter/cupertino.dart';

class ImageListCarousel extends StatefulWidget {
  final List<Widget> imageWidgetList;
  final Widget runPic;
  const ImageListCarousel({required this.imageWidgetList, required this.runPic, Key? key})
      : super(key: key);

  @override
  State<ImageListCarousel> createState() => _ImageListCarouselState();
}

class _ImageListCarouselState extends State<ImageListCarousel> {
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> imageWidgetList;
  late List<Widget> allImageWidgets;

  @override
  void initState() {
    print('새로운위젯??');
    imageWidgetList = widget.imageWidgetList;
    imageWidgetList.add(widget.runPic);
    allImageWidgets = imageWidgetList;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.runPic);
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: PageView.builder(
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return allImageWidgets[index];
          },
          itemCount: widget.imageWidgetList.length,
        ),);
  }
}

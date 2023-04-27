import 'package:another/constant/color.dart';
import 'package:another/screens/feed/widgets/image_box.dart';
import 'package:flutter/material.dart';

class MyFeedScreen extends StatelessWidget {
  const MyFeedScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyFeedBox(),
            ImageBox(),
          ],
        ),
      ),
    );
  }
}

class MyFeedBox extends StatelessWidget {
  const MyFeedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 16.0,
      ),
      child: Container(
        height: 150.0,
        color: WHITE_COLOR,
      ),
    );
  }
}

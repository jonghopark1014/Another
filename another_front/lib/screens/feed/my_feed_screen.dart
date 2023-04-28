import 'package:another/constant/color.dart';
import 'package:another/screens/feed/widgets/image_box.dart';
import 'package:another/screens/feed/widgets/my_feed_result.dart';
import 'package:flutter/material.dart';

class MyFeedScreen extends StatelessWidget {
  const MyFeedScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageBox(),
            ],
        ),
    );
  }
}



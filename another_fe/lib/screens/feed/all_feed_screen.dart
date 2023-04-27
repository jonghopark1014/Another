import 'package:another/screens/feed/widgets/image_box.dart';
import 'package:flutter/material.dart';

import 'my_feed_screen.dart';

class AllFeedScreen extends StatelessWidget {
  const AllFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageBox(),
        ],
      ),
    );
  }
}


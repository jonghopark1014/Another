import 'package:another/screens/feed/my_feed_screen.dart';
import 'package:flutter/material.dart';

import '../../../constant/color.dart';

class FeedSelect extends StatefulWidget {
  final ValueChanged<bool> onChanged;

  FeedSelect({
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<FeedSelect> createState() => _FeedSelectState();
}

class _FeedSelectState extends State<FeedSelect> {
  bool isFeed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                isFeed = false;
              });
              widget.onChanged(!isFeed);
            },
            style: TextButton.styleFrom(
              fixedSize: Size(100.0, 10.0),
            ),
            child: Text(
              '전체 피드',
              style: TextStyle(
                color: isFeed ?  SERVETWO_COLOR : WHITE_COLOR,
                fontSize: 20.0,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isFeed = true;
              });
              widget.onChanged(!isFeed);
            },
            style: TextButton.styleFrom(fixedSize: Size(100.0, 10.0)),
            child: Text(
              '나의피드',
              style: TextStyle(
                color: isFeed ?  WHITE_COLOR : SERVETWO_COLOR,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

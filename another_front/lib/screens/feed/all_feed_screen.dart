import 'package:another/screens/feed/widgets/image_box.dart';
import 'package:flutter/material.dart';

class AllFeedScreen extends StatelessWidget {
  List<String> thumbnailUrls = [];
  List<String> runningIds = [];
  List<String> runningTimes = [];
  List<String> runningDistances = [];
  List<String> userCalories = [];

  AllFeedScreen({
    required this.thumbnailUrls,
    required this.runningIds,
    required this.runningTimes,
    required this.runningDistances,
    required this.userCalories,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageBox(
            thumbnailUrls: thumbnailUrls,
            runningIds: runningIds,
            runningTimes: runningTimes,
            runningDistances: runningDistances,
            userCalories: userCalories,
          ),
        ],
      ),
    );
  }
}

import 'package:another/screens/feed/feed.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/material.dart';

import '../../constant/color.dart';

class UnderChanllengeScreen extends StatelessWidget {
  const UnderChanllengeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Target(targetRecord: '목표기록',),
              Target(targetRecord: '내기록',),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => FeedScreen()),
                      (route) => false);
                },
                child: Text('Pop'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

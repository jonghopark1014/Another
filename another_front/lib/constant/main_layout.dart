import 'package:another/constant/color.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  PreferredSizeWidget? appBar;


  MainLayout({
    required this.body,
    this.appBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        child: Scaffold(
          appBar: appBar,
          body: body,
        ),
      ),
    );
  }
}

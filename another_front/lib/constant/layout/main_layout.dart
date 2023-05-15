import 'package:another/constant/const/color.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  final Color? backgroundColor;

  MainLayout({
    required this.body,
    this.title,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Scaffold(
          appBar: renderAppbar(),
          body: body,
        ),
      ),
    );
  }


  AppBar? renderAppbar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: backgroundColor ?? BACKGROUND_COLOR,
        elevation: 0,
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
      );
    }
  }
}

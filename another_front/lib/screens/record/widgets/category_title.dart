import 'package:flutter/material.dart';
import 'package:another/constant/const/color.dart';

class CategoryTitle extends StatelessWidget {
  final title;
  double top;
  double bottom;
  CategoryTitle({Key? key, required this.title, required this.top, required this.bottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: top, bottom: bottom),
          child: Container(
            child: Text(
              '$title',
              style: TextStyle(
                color: WHITE_COLOR,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

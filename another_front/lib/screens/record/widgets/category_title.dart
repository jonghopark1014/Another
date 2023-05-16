import 'package:flutter/material.dart';
import 'package:another/constant/const/color.dart';

class CategoryTitle extends StatelessWidget {
  final title;
  CategoryTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            '$title',
            style: TextStyle(
              color: WHITE_COLOR,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

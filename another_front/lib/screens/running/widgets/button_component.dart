import 'package:another/constant/const/color.dart';
import 'package:another/constant/const/text_style.dart';
import 'package:flutter/material.dart';


class ButtonConponent extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback feedComplete;

  const ButtonConponent({
    required this.feedComplete,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: feedComplete,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            primary: SERVETWO_COLOR,
            elevation: 10.0,
          ),
          child: Text(
            '다음에 할래요!',
            style: MyTextStyle.twentyTextStyle
          ),
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: MAIN_COLOR,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            elevation: 10.0,
          ),
          child: Text(
            '오운완 등록하기',
            style: MyTextStyle.twentyTextStyle,
          ),
        )
      ],
    );
  }
}

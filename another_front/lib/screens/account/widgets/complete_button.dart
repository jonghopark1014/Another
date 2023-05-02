import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';

class CompleteButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const CompleteButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      margin: EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text('$text'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(MAIN_COLOR),
        ),
      ),
    );
  }
}

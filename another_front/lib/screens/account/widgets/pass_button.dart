import 'package:flutter/material.dart';
import 'package:another/constant/const/color.dart';

class PassButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const PassButton({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      margin: EdgeInsets.only(bottom: 20),
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide>(
                (Set<MaterialState> states) {
              return BorderSide(color: MAIN_COLOR, width: 2);
            },
          ),
        ),
        child: Text(
          '$text',
          style: TextStyle(color: MAIN_COLOR),
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/const/color.dart';

class RunningCircleButton extends StatelessWidget {
  final IconData iconNamed;
  final VoidCallback onPressed;

  const RunningCircleButton({
    required this.iconNamed,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.1;
    return MaterialButton(
      color: MAIN_COLOR,
      onPressed: onPressed,
      // onPressed: () {},
      shape: CircleBorder(),
      elevation: 8,
      padding: EdgeInsets.all(35.0),
      child: Icon(
        iconNamed,
        size: width < 60 ? width : 60,
      ),
    );
  }
}

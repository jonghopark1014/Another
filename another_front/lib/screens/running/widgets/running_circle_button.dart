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
    return RawMaterialButton(
      onPressed: onPressed,
      // onPressed: () {},
      shape: CircleBorder(),
      elevation: 8,
      fillColor: MAIN_COLOR,
      child: Icon(
        iconNamed,
        size: 60,
      ),
      padding: EdgeInsets.all(35.0),
    );
  }
}

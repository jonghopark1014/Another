import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/const/color.dart';

class RunningSmallButton extends StatelessWidget {
  final IconData iconNamed;
  final VoidCallback onPressed;

  const RunningSmallButton({
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
      elevation: 2.0,
      fillColor: SERVEONE_COLOR,
      padding: EdgeInsets.all(15),
      child: Icon(
        iconNamed,
        size: 50,
      ),
    );
  }
}
